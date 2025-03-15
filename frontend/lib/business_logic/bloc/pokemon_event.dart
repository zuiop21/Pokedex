part of 'pokemon_bloc.dart';

sealed class PokemonEvent extends Equatable {}

final class GetPokemonEvent extends PokemonEvent {
  GetPokemonEvent({required this.token});
  final String token;
  @override
  List<Object?> get props => [token];
}

final class SortPokemonByTypeEvent extends PokemonEvent {
  SortPokemonByTypeEvent({required this.dropDownValue});
  final String dropDownValue;
  @override
  List<Object?> get props => [dropDownValue];
}

final class OrderPokemonByNumberEvent extends PokemonEvent {
  OrderPokemonByNumberEvent({required this.dropDownValue});
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

final class SortPokemonByRegionEvent extends PokemonEvent {
  SortPokemonByRegionEvent({required this.region});
  final Region? region;
  @override
  List<Object?> get props => [region];
}

final class FavouritePokemonEvent extends PokemonEvent {
  final Pokemon pokemon;

  FavouritePokemonEvent({required this.pokemon});
  @override
  List<Object?> get props => [pokemon];
}
