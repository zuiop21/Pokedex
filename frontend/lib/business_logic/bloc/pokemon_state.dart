part of 'pokemon_bloc.dart';

//Enum to represent the status of the Pokemon view
enum PokemonStatus { initial, loading, success, failure }

//Extension to add helper methods to the PokemonStatus enum
extension PokemonStatusX on PokemonStatus {
  bool get isInitial => this == PokemonStatus.initial;
  bool get isLoading => this == PokemonStatus.loading;
  bool get isSuccess => this == PokemonStatus.success;
  bool get isFailure => this == PokemonStatus.failure;
}

final class PokemonState extends Equatable {
  final bool changed;
  final PokemonStatus status;
  final Map<int, Pokemon> pokemons;
  final List<Type> types;
  final List<Evolution> evolutions;
  final List<Region> regions;
  final String? error;

  final String searchBarValue;
  final String dropDownValue1;
  final String dropDownValue2;
  final Region? regionFilter;
  final List<Pokemon> filteredPokemons;

  //Method to find a pokemon by its id
  Pokemon? getPokemonById(int id) => pokemons[id];

  //Method to find pokemons with base forms by region
  List<Pokemon> findBaseFormsByRegion(Region region) {
    return pokemons.values
        .where((p) => p.regionId == region.id && p.isBaseForm)
        .toList();
  }

//Method to find pokemons that are favourited
  List<Pokemon> findFavouritedPokemons() {
    return pokemons.values.where((p) => p.isFavourited).toList();
  }

//Helper method to find the evolution chain of a pokemon backward in the list
  Set<Pokemon> _backwardInChain(Pokemon pokemon, {Set<int>? visited}) {
    final Set<Pokemon> evolutionChain = {};
    visited ??= {};

    if (visited.contains(pokemon.id)) return evolutionChain;
    visited.add(pokemon.id);

    for (var e in evolutions) {
      if (e.evolvesToId == pokemon.id) {
        final prevPokemon = pokemons[e.pokemonId];
        if (prevPokemon != null && evolutionChain.add(prevPokemon)) {
          evolutionChain
              .addAll(_backwardInChain(prevPokemon, visited: visited));
        }
      }
    }

    return evolutionChain;
  }

//Helper method to find the evolution chain of a pokemon forward in the list
  Set<Pokemon> _forwardInChain(Pokemon pokemon, {Set<int>? visited}) {
    final Set<Pokemon> evolutionChain = {};
    visited ??= {};

    if (visited.contains(pokemon.id)) return evolutionChain;
    visited.add(pokemon.id);

    for (var e in evolutions) {
      if (pokemon.evolvesTo?.id == e.evolvesToId) {
        final nextPokemon = pokemons[pokemon.evolvesTo?.id];
        if (nextPokemon != null && evolutionChain.add(nextPokemon)) {
          evolutionChain.addAll(_forwardInChain(nextPokemon, visited: visited));
        }
      }
    }

    return evolutionChain;
  }

//Method to find the evolution chain of a pokemon
//We use two recursive helper methods to iterare through the list
  List<Pokemon> findEvolutionChain(Pokemon pokemon) {
    final Set<Pokemon> evolutionChain = {
      ..._backwardInChain(pokemon),
      ..._forwardInChain(pokemon),
      pokemon
    };

    return evolutionChain.toList()..sort((a, b) => a.id.compareTo(b.id));
  }
  // flutter: (Evolution(49, 49, null, null), Evolution(50, 50, 51, DASD), Evolution(51, 51, null, null),
  // ..., Evolution(56, 54, 55, DASD), Evolution(57, 55, null, null))

  //flutter: (Evolution(49, 49, null, null), Evolution(50, 50, 51, DASD), Evolution(51, 51, null, null),
  //..., Evolution(56, 54, 55, DASD), Evolution(57, 55, null, null))

//Constructor for the PokemonState
  const PokemonState({
    this.changed = false,
    this.dropDownValue1 = "All Types",
    this.dropDownValue2 = "Ascending",
    this.searchBarValue = "",
    this.pokemons = const {},
    this.evolutions = const [],
    this.regions = const [],
    this.filteredPokemons = const [],
    this.types = const [],
    this.error,
    this.regionFilter,
    this.status = PokemonStatus.initial,
  });

//Method to copy the PokemonState with new values
  PokemonState copyWith({
    PokemonStatus? status,
    Map<int, Pokemon>? pokemons,
    List<Pokemon>? filteredPokemons,
    List<Type>? types,
    List<Evolution>? evolutions,
    List<Region>? regions,
    String? error,
    String? dropDownValue1,
    String? dropDownValue2,
    String? searchBarValue,
    ValueGetter<Region?>? regionFilter,
    bool? changed,
  }) {
    return PokemonState(
      status: status ?? this.status,
      error: error ?? this.error,
      pokemons: pokemons ?? this.pokemons,
      types: types ?? this.types,
      dropDownValue1: dropDownValue1 ?? this.dropDownValue1,
      dropDownValue2: dropDownValue2 ?? this.dropDownValue2,
      filteredPokemons: filteredPokemons ?? this.filteredPokemons,
      searchBarValue: searchBarValue ?? this.searchBarValue,
      evolutions: evolutions ?? this.evolutions,
      regions: regions ?? this.regions,
      regionFilter: regionFilter != null ? regionFilter() : this.regionFilter,
      changed: changed ?? this.changed,
    );
  }

//Method to compare the PokemonState with another object
  @override
  List<Object?> get props => [
        status,
        error,
        pokemons,
        types,
        dropDownValue1,
        dropDownValue2,
        filteredPokemons,
        searchBarValue,
        evolutions,
        regions,
        regionFilter,
        changed
      ];
}
