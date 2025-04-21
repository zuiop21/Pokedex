import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_tile_types.dart';

//A widget that displays some basic information of a pokemon
//Such as the name, id, types and description
class PokemonBasicInfo extends StatelessWidget {
  final int pokemonId;
  const PokemonBasicInfo({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    //Find the pokemon by it's id
    final pokemon = context.read<PokemonBloc>().state.getPokemonById(pokemonId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pokemon!.name,
              style: const TextStyle(fontSize: 36),
            ),
            Text(
              "Number ${pokemon.id}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        //Strength types of the pokemon
        PokemonTileTypes(
          pokemonId: pokemon.id,
          leftPadding: 0,
        ),
        Text(pokemon.description, style: const TextStyle(fontSize: 18))
      ],
    );
  }
}
