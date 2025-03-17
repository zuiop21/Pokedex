import 'package:equatable/equatable.dart';
import 'package:frontend/data/models/raw/raw_evolution.dart';

//Class to represent the evolution of a pokemon
class Evolution extends Equatable {
  const Evolution(
      {required this.id,
      required this.pokemonId,
      this.evolvesToId,
      this.condition});

  final int id;
  final int pokemonId;
  final int? evolvesToId;
  final String? condition;

//Method to create an Evolution object from a RawEvolution object
  factory Evolution.fromRaw(RawEvolution rawEvolution) {
    return Evolution(
        id: rawEvolution.id,
        pokemonId: rawEvolution.pokemon_id,
        evolvesToId: rawEvolution.evolves_to_id,
        condition: rawEvolution.condition);
  }

  @override
  List<Object?> get props => [id, pokemonId, evolvesToId, condition];
}
