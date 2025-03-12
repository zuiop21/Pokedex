part of 'pokemon_bloc.dart';

enum PokemonStatus { initial, loading, success, failure }

extension PokemonStatusX on PokemonStatus {
  bool get isInitial => this == PokemonStatus.initial;
  bool get isLoading => this == PokemonStatus.loading;
  bool get isSuccess => this == PokemonStatus.success;
  bool get isFailure => this == PokemonStatus.failure;
}

final class PokemonState extends Equatable {
  final PokemonStatus status;
  final List<Pokemon> pokemons;
  final List<Pokemon> filteredPokemons;
  final List<Type> types;
  final List<Evolution> evolutions;
  final List<Region> regions;
  final String? error;
  final String searchBarValue;
  final String dropDownValue1;
  final String dropDownValue2;

  Set<Pokemon> _backwardInChain(Pokemon pokemon, {Set<int>? visited}) {
    final Set<Pokemon> evolutionChain = {};
    visited ??= {};

    if (visited.contains(pokemon.id)) return evolutionChain;
    visited.add(pokemon.id);

    for (var e in evolutions) {
      if (e.evolves_to_id == pokemon.id) {
        final prevPokemon =
            pokemons.firstWhereOrNull((p) => p.id == e.pokemon_id);
        if (prevPokemon != null && evolutionChain.add(prevPokemon)) {
          evolutionChain
              .addAll(_backwardInChain(prevPokemon, visited: visited));
        }
      }
    }
    return evolutionChain;
  }

  Set<Pokemon> _forwardInChain(Pokemon pokemon, {Set<int>? visited}) {
    final Set<Pokemon> evolutionChain = {};
    visited ??= {};

    if (visited.contains(pokemon.id)) return evolutionChain;
    visited.add(pokemon.id);

    for (var e in evolutions) {
      if (pokemon.evolves_to_id == e.evolves_to_id) {
        final nextPokemon =
            pokemons.firstWhereOrNull((p) => p.id == pokemon.evolves_to_id);
        if (nextPokemon != null && evolutionChain.add(nextPokemon)) {
          evolutionChain.addAll(_forwardInChain(nextPokemon, visited: visited));
        }
      }
    }
    return evolutionChain;
  }

  List<Pokemon> findEvolutionChain(Pokemon pokemon) {
    final Set<Pokemon> evolutionChain = {};

    evolutionChain.addAll(_backwardInChain(pokemon));

    evolutionChain.addAll(_forwardInChain(pokemon));

    evolutionChain.add(pokemon);

    List<Pokemon> chainList = evolutionChain.toList()
      ..sort((a, b) => a.id.compareTo(b.id));

    return chainList;
  }

  const PokemonState({
    this.dropDownValue1 = "All Types",
    this.dropDownValue2 = "Ascending",
    this.searchBarValue = "",
    this.pokemons = const [],
    this.evolutions = const [],
    this.regions = const [],
    this.filteredPokemons = const [],
    this.types = const [],
    this.error,
    this.status = PokemonStatus.initial,
  });

  PokemonState copyWith({
    PokemonStatus? status,
    List<Pokemon>? pokemons,
    List<Pokemon>? filteredPokemons,
    List<Type>? types,
    List<Evolution>? evolutions,
    List<Region>? regions,
    String? error,
    String? dropDownValue1,
    String? dropDownValue2,
    String? searchBarValue,
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
        regions: regions ?? this.regions);
  }

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
        regions
      ];
}
