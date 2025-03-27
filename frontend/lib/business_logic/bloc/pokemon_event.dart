part of 'pokemon_bloc.dart';

//Main class for the Pokemon events
sealed class PokemonEvent extends Equatable {}

//Event to get all the data from the repository
final class GetPokemonEvent extends PokemonEvent {
  GetPokemonEvent({required this.token});
  final String token;
  @override
  List<Object?> get props => [token];
}

//Event to sort the pokemons by type
final class SortPokemonByTypeEvent extends PokemonEvent {
  SortPokemonByTypeEvent({required this.dropDownValue});
  final String dropDownValue;
  @override
  List<Object?> get props => [dropDownValue];
}

//Event to order the pokemons by id
final class OrderPokemonByIdEvent extends PokemonEvent {
  OrderPokemonByIdEvent({required this.dropDownValue});
  final String dropDownValue;
  @override
  List<Object?> get props => [dropDownValue];
}

//Event to sort the pokemons by name
final class SortPokemonByNameEvent extends PokemonEvent {
  SortPokemonByNameEvent({required this.searchBarValue});
  final String searchBarValue;
  @override
  List<Object?> get props => [searchBarValue];
}

//Event to sort the pokemons by region
final class SortPokemonByRegionEvent extends PokemonEvent {
  SortPokemonByRegionEvent({required this.region});
  final Region? region;
  @override
  List<Object?> get props => [region];
}

final class ResetSearchBarEvent extends PokemonEvent {
  @override
  List<Object?> get props => [];
}

final class UpdateTypeEvent extends PokemonEvent {
  UpdateTypeEvent({required this.type});
  final Type type;
  @override
  List<Object?> get props => [
        type,
      ];
}

final class DeleteTypeEvent extends PokemonEvent {
  DeleteTypeEvent({required this.type});
  final Type type;
  @override
  List<Object?> get props => [type];
}

final class CreateNewTypeEvent extends PokemonEvent {
  CreateNewTypeEvent({required this.newType});
  final Type newType;
  @override
  List<Object?> get props => [
        newType,
      ];
}

final class FavouriteEvent extends PokemonEvent {
  FavouriteEvent({required this.pokemon, required this.token});

  final Pokemon pokemon;
  final String token;
  @override
  List<Object?> get props => [pokemon, token];
}
