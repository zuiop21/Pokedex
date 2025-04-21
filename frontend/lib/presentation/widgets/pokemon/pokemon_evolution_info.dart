import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_evolves_to_container.dart';

//A widget that displays the evolutions of a pokemon
class PokemonEvolutionInfo extends StatelessWidget {
  final int pokemonId;
  const PokemonEvolutionInfo({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    //Find the pokemon by it's id
    final pokemon = context.read<PokemonBloc>().state.getPokemonById(pokemonId);

    //Find the evolution chain of the pokemon
    final evolutionChain =
        context.read<PokemonBloc>().state.findEvolutionChain(pokemon!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Evolutions",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.lightGrey, width: 1),
            color: Colors.white,
          ),
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 0,
              childAspectRatio: 2.5,
            ),
            itemCount: evolutionChain.length,
            itemBuilder: (context, index) {
              return PokemonEvolvesToContainer(
                pokemonId: evolutionChain[index].id,
              );
            },
          ),
        ),
      ],
    );
  }
}
