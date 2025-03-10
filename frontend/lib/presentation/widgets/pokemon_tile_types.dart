import 'package:flutter/material.dart';
import 'package:frontend/data/models/pokemon.dart';
import 'package:frontend/data/models/type.dart';

class PokemonTileTypes extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonTileTypes({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final List<Type> strengthsTypes = pokemon.getStrengthTypesForPokemon();
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 10, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Color(int.parse(strengthsTypes[0].color)),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 25),
                  SizedBox(width: 5),
                  Text(
                    strengthsTypes[0].name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          if (strengthsTypes.length == 2)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: IntrinsicWidth(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(int.parse(strengthsTypes[1].color)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 25),
                      SizedBox(width: 5),
                      Text(
                        strengthsTypes[1].name,
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
