import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/models/processed/evolution.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/region.dart';
import 'package:frontend/data/repositories/pokemon_repository.dart';
import 'package:frontend/data/models/processed/type.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

//Main business logic class for the Pokemon view
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository;

  PokemonBloc(this._pokemonRepository) : super(const PokemonState()) {
    on<GetPokemonEvent>(_getAllData);
    on<SortPokemonByTypeEvent>(_sortByType);
    on<OrderPokemonByIdEvent>(_orderById);
    on<SortPokemonByNameEvent>(_sortByName);
    on<SortPokemonByRegionEvent>(_sortByRegion);
    on<ResetSearchBarEvent>(_resetSearchBar);
    on<UpdateTypeEvent>(_updateType);
    on<DeleteTypeEvent>(_deleteType);
    on<CreateNewTypeEvent>(_createType);
    on<FavouriteEvent>(_changeFavouriteStatus);
    on<CreateNewPokemonEvent>(_createPokemon);
    on<DeletePokemonEvent>(_deletePokemon);
    on<CreateNewRegionEvent>(_createRegion);
    on<DeleteRegionEvent>(_deleteRegion);
    on<UpdateRegionEvent>(_updateRegion);
  }

  void _updateRegion(
      UpdateRegionEvent event, Emitter<PokemonState> emit) async {
    final updatedRegions = state.regions.map((region) {
      if (region.id == event.region.id) {
        return event.region;
      }
      return region;
    }).toList();

    emit(state.copyWith(regions: updatedRegions));
  }

  void _deleteRegion(
      DeleteRegionEvent event, Emitter<PokemonState> emit) async {
    final updatedRegions =
        state.regions.where((r) => r.id != event.region.id).toList();

    emit(state.copyWith(regions: updatedRegions));
  }

  void _createRegion(
      CreateNewRegionEvent event, Emitter<PokemonState> emit) async {
    final updatedRegions = [...state.regions, event.newRegion];

    emit(state.copyWith(regions: updatedRegions));
  }

  void _deletePokemon(
      DeletePokemonEvent event, Emitter<PokemonState> emit) async {
    final updatedMap = Map<int, Pokemon>.from(state.pokemons)
      ..remove(event.pokemon.id);

    emit(state.copyWith(pokemons: updatedMap));
  }

  void _createPokemon(
      CreateNewPokemonEvent event, Emitter<PokemonState> emit) async {
    final updatedMap = Map<int, Pokemon>.from(state.pokemons);

    for (final pokemon in event.pokemons) {
      updatedMap[pokemon.id] = pokemon;
    }
    final updatedEvolutions = [...state.evolutions, ...event.evolutions];
    emit(state.copyWith(pokemons: updatedMap, evolutions: updatedEvolutions));
  }

  Future<void> _changeFavouriteStatus(
      FavouriteEvent event, Emitter<PokemonState> emit) async {
    final originalList = state.pokemons;
    //Update list optimistically
    final updatedPokemons = Map.fromEntries(
      state.pokemons.entries.map((entry) => entry.value.id == event.pokemon.id
          ? MapEntry(entry.key,
              entry.value.copyWith(isFavourited: !entry.value.isFavourited))
          : MapEntry(entry.key, entry.value)),
    );

    emit(state.copyWith(
        status: PokemonStatus.success, pokemons: updatedPokemons));

    //Sync with server
    try {
      if (event.pokemon.isFavourited) {
        await _pokemonRepository.removeFavouritePokemon(
            event.token, event.pokemon.id);
      } else {
        await _pokemonRepository.addFavouritePokemon(
            event.token, event.pokemon.id);
      }
    }
    //If request fails, revert the changes
    catch (e) {
      emit(state.copyWith(
          status: PokemonStatus.failure,
          error: e.toString(),
          pokemons: originalList));
    }
  }

  void _createType(CreateNewTypeEvent event, Emitter<PokemonState> emit) {
    final List<Type> updatedTypes = [...state.types, event.newType];

    emit(state.copyWith(types: updatedTypes));
  }

  void _deleteType(DeleteTypeEvent event, Emitter<PokemonState> emit) {
    final List<Type> updatedTypes =
        state.types.where((t) => t.id != event.type.id).toList();
    final updatedPokemons = Map.fromEntries(
      state.pokemons.entries.map(
        (entry) => MapEntry(entry.key, entry.value.deleteType(event.type)),
      ),
    );

    emit(state.copyWith(types: updatedTypes, pokemons: updatedPokemons));
  }

  void _updateType(UpdateTypeEvent event, Emitter<PokemonState> emit) {
    final List<Type> updatedTypes = state.types.map((type) {
      if (type.id == event.type.id) {
        return event.type;
      }
      return type;
    }).toList();

    final updatedPokemons = Map.fromEntries(
      state.pokemons.entries.map(
        (entry) => MapEntry(entry.key, entry.value.updateTypes(event.type)),
      ),
    );

    emit(state.copyWith(types: updatedTypes, pokemons: updatedPokemons));
  }

  //Method to get all the data from the repository
  Future<void> _getAllData(
      GetPokemonEvent event, Emitter<PokemonState> emit) async {
    emit(state.copyWith(status: PokemonStatus.loading));
    try {
      final pokemonsList = await _pokemonRepository.getAllPokemons(event.token);
      final types = await _pokemonRepository.getAllTypes();
      final regions = await _pokemonRepository.getAllRegions();
      final evolutions = await _pokemonRepository.getAllEvolutions();

      final Map<int, Pokemon> pokemons = {for (var p in pokemonsList) p.id: p};

      emit(state.copyWith(
        status: PokemonStatus.success,
        pokemons: pokemons,
        filteredPokemons: pokemons.values.toList(),
        types: types,
        regions: regions,
        evolutions: evolutions,
      ));
    } catch (e) {
      emit(state.copyWith(status: PokemonStatus.failure, error: e.toString()));
    }
  }

  //Method to apply the filter and ordering to the pokemons
  //We use a different list to store the filtered pokemons,
  //leaving the original list untouched
  void _applyFilterAndOrdering(Emitter<PokemonState> emit) {
    List<Pokemon> filteredPokemons = state.pokemons.values.toList();

    //Filtering by type
    if (state.dropDownValue1 != "All Types") {
      filteredPokemons = filteredPokemons
          .where((p) => p
              .getStrengthTypesForPokemon()
              .any((s) => s.name == state.dropDownValue1))
          .toList();
    }

    //Filtering by name
    if (state.searchBarValue.isNotEmpty) {
      filteredPokemons = filteredPokemons
          .where((p) => p.name
              .toLowerCase()
              .startsWith(state.searchBarValue.toLowerCase()))
          .toList();
    }

    //Filtering by region
    if (state.regionFilter != null) {
      filteredPokemons = filteredPokemons
          .where((p) => p.regionId == state.regionFilter?.id)
          .toList();
    }

    switch (state.dropDownValue2) {
      case "Ascending":
        filteredPokemons.sort((a, b) => a.id.compareTo(b.id));
        break;
      case "Descending":
        filteredPokemons.sort((a, b) => b.id.compareTo(a.id));
        break;
      case "A-Z":
        filteredPokemons.sort((a, b) => a.name.compareTo(b.name));
        break;
      case "Z-A":
        filteredPokemons.sort((a, b) => b.name.compareTo(a.name));
        break;
    }

    emit(state.copyWith(filteredPokemons: filteredPokemons));
  }

//Method that gets called when we want to sort the pokemons by type
  void _sortByType(SortPokemonByTypeEvent event, Emitter<PokemonState> emit) {
    emit(state.copyWith(dropDownValue1: event.dropDownValue));
    _applyFilterAndOrdering(emit);
  }

//Method that gets called when we want to sort the pokemons by name
  void _sortByName(SortPokemonByNameEvent event, Emitter<PokemonState> emit) {
    emit(state.copyWith(searchBarValue: event.searchBarValue));
    _applyFilterAndOrdering(emit);
  }

//Method that gets called when we want to sort the pokemons by id
  void _orderById(OrderPokemonByIdEvent event, Emitter<PokemonState> emit) {
    emit(state.copyWith(dropDownValue2: event.dropDownValue));
    _applyFilterAndOrdering(emit);
  }

//Method that gets called when we want to sort the pokemons by region
  void _sortByRegion(
      SortPokemonByRegionEvent event, Emitter<PokemonState> emit) {
    emit(state.copyWith(regionFilter: () => event.region, searchBarValue: ""));
    _applyFilterAndOrdering(emit);
  }

  void _resetSearchBar(ResetSearchBarEvent event, Emitter<PokemonState> emit) {
    emit(state.copyWith(searchBarValue: ""));
    _applyFilterAndOrdering(emit);
  }
}
