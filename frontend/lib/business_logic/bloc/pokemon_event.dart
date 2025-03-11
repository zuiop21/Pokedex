part of 'pokemon_bloc.dart';

sealed class PokemonEvent extends Equatable {}

final class GetPokemonEvent extends PokemonEvent {
  @override
  List<Object?> get props => [];
}

final class SortPokemonByTypeEvent extends PokemonEvent {
  SortPokemonByTypeEvent({required this.dropDownValue});
  final String dropDownValue;
  @override
  List<Object?> get props => [dropDownValue];
}

final class SortPokemonByNumberEvent extends PokemonEvent {
  SortPokemonByNumberEvent({required this.dropDownValue});
  final String dropDownValue;
  @override
  List<Object?> get props => [dropDownValue];
}

final class SortPokemonByNameEvent extends PokemonEvent {
  SortPokemonByNameEvent({required this.searchBarValue});
  final String searchBarValue;
  @override
  List<Object?> get props => [searchBarValue];
}
