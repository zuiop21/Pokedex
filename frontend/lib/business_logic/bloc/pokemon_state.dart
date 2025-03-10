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
  final String? error;

  const PokemonState({
    this.pokemons = const [],
    this.error,
    this.status = PokemonStatus.initial,
  });

  PokemonState copyWith({
    PokemonStatus? status,
    List<Pokemon>? pokemons,
    String? error,
  }) {
    return PokemonState(
        status: status ?? this.status,
        error: error ?? this.error,
        pokemons: pokemons ?? this.pokemons);
  }

  @override
  List<Object?> get props => [status, error, pokemons];
}
