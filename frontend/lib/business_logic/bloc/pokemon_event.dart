part of 'pokemon_bloc.dart';

sealed class PokemonEvent extends Equatable {}

final class GetPokemonEvent extends PokemonEvent {
  @override
  List<Object?> get props => [];
}
