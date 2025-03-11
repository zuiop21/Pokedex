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
  final String? error;
  final String searchBarValue;
  final String dropDownValue1;
  final String dropDownValue2;

  const PokemonState({
    this.dropDownValue1 = "All Types",
    this.dropDownValue2 = "Ascending",
    this.searchBarValue = "",
    this.pokemons = const [],
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
        searchBarValue: searchBarValue ?? this.searchBarValue);
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
        searchBarValue
      ];
}
