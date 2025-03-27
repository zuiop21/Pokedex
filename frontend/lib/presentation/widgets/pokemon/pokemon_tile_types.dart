import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_circled_type.dart';

//A widget that displays the types of a pokemon
class PokemonTileTypes extends StatelessWidget {
  final int pokemonId;

  final double leftPadding;
  const PokemonTileTypes({
    super.key,
    required this.pokemonId,
    required this.leftPadding,
  });

  @override
  Widget build(BuildContext context) {
    //Find the pokemon by it's id
    final pokemon = context.read<PokemonBloc>().state.getPokemonById(pokemonId);
    //Find the strength types of the pokemon
    final List<Type> strengthTypes = pokemon!.getStrengthTypesForPokemon();
    return Padding(
      padding: EdgeInsets.only(bottom: 5, left: leftPadding, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (strengthTypes.isNotEmpty)
            IntrinsicWidth(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(int.parse(strengthTypes[0].color)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    PokemonCircledType(type: strengthTypes[0]),
                    SizedBox(width: 5),
                    Text(
                      strengthTypes[0].name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          if (strengthTypes.length == 2)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: IntrinsicWidth(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(int.parse(strengthTypes[1].color)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      PokemonCircledType(type: strengthTypes[1]),
                      SizedBox(width: 5),
                      Text(
                        strengthTypes[1].name,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
