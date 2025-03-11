import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/models/pokemon.dart';
import 'package:frontend/data/repositories/pokemon_repository.dart';
import 'package:frontend/data/models/type.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository;
  PokemonBloc(this._pokemonRepository) : super(PokemonState()) {
    on<GetPokemonEvent>(_getAllData);
    on<SortPokemonByTypeEvent>(_sortByType);
    on<SortPokemonByNumberEvent>(_orderByNumber);
    on<SortPokemonByNameEvent>(_sortByName);
  }
  Future<void> _getAllData(
      GetPokemonEvent event, Emitter<PokemonState> emit) async {
    emit(state.copyWith(status: PokemonStatus.loading));
    try {
      final pokemons = await _pokemonRepository.getAllPokemons();
      final types = await _pokemonRepository.getAllTypes();

      final allTypesOption = Type(
        name: "All Types",
        color: "0xFF333333",
        imgUrl: "",
        imgUrlOutline: "",
        PokemonTypes: null,
      );

      final updatedTypes = [allTypesOption, ...types];

      emit(state.copyWith(
        status: PokemonStatus.success,
        pokemons: pokemons,
        filteredPokemons: pokemons,
        types: updatedTypes,
      ));
    } catch (e) {
      emit(state.copyWith(status: PokemonStatus.failure, error: e.toString()));
    }
  }

  void _applyFilterAndOrdering(Emitter<PokemonState> emit) {
    List<Pokemon> filteredPokemons = state.pokemons;

    if (state.dropDownValue1 != "All Types") {
      filteredPokemons = filteredPokemons
          .where((p) => p
              .getStrengthTypesForPokemon()
              .any((s) => s.name == state.dropDownValue1))
          .toList();
    }

    if (state.searchBarValue.isNotEmpty) {
      filteredPokemons = filteredPokemons
          .where((p) => p.name
              .toLowerCase()
              .startsWith(state.searchBarValue.toLowerCase()))
          .toList();
    }

    if (state.dropDownValue2 == "Ascending") {
      filteredPokemons.sort((a, b) => a.id.compareTo(b.id));
    } else if (state.dropDownValue2 == "Descending") {
      filteredPokemons.sort((a, b) => b.id.compareTo(a.id));
    } else if (state.dropDownValue2 == "A-Z") {
      filteredPokemons.sort((a, b) => a.name.compareTo(b.name));
    } else if (state.dropDownValue2 == "Z-A") {
      filteredPokemons.sort((a, b) => b.name.compareTo(a.name));
    }

    emit(state.copyWith(filteredPokemons: filteredPokemons));
  }

  void _sortByType(SortPokemonByTypeEvent event, Emitter<PokemonState> emit) {
    emit(state.copyWith(dropDownValue1: event.dropDownValue));
    _applyFilterAndOrdering(emit);
  }

  void _sortByName(SortPokemonByNameEvent event, Emitter<PokemonState> emit) {
    emit(state.copyWith(searchBarValue: event.searchBarValue));
    _applyFilterAndOrdering(emit);
  }

  void _orderByNumber(
      SortPokemonByNumberEvent event, Emitter<PokemonState> emit) {
    emit(state.copyWith(dropDownValue2: event.dropDownValue));
    _applyFilterAndOrdering(emit);
  }
}
