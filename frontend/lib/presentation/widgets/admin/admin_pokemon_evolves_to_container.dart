import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/admin/admin_pokemon_evolution_types.dart';
import 'package:frontend/presentation/widgets/other/blurred_image.dart';

//A widget that displays the evolutions of a pokemon
class AdminPokemonEvolvesToContainer extends StatelessWidget {
  final int index;

  const AdminPokemonEvolvesToContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    //Find the pokemon by it's id
    final pokemon = context.read<AdminBloc>().state.newPokemons[index];
    final strengthTypes = pokemon.getStrengthTypesForPokemon();
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        children: [
          Expanded(
            flex: 65,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: AppColors.lightGrey, width: 1),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 33,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse(strengthTypes[0].color),
                        ),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: BlurredImage(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight,
                                  beginValue: 0.15,
                                  endValue: 1.0,
                                  pokemon: pokemon,
                                  child: strengthTypes[0]
                                          .imgUrlOutline
                                          .isNotEmpty
                                      ? CachedNetworkImage(
                                          fit: BoxFit.contain,
                                          imageUrl:
                                              strengthTypes[0].imgUrlOutline,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                      : const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: context
                                      .read<AdminBloc>()
                                      .state
                                      .images[index]
                                      .path
                                      .isNotEmpty
                                  ? Image.file(
                                      context
                                          .read<AdminBloc>()
                                          .state
                                          .images[index],
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stack) =>
                                          const Icon(Icons.error),
                                    )
                                  : const Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 67,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pokemon.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Number $index",
                            style: const TextStyle(fontSize: 16),
                          ),
                          AdminPokemonEvolutionTypes(index: index),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 35,
            child:
                // evolution.condition != null && evolution.condition!.isNotEmpty
                //     ? Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(Icons.arrow_downward),
                //           Text(evolution.condition!),
                //         ],
                //       )
                //     :
                SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
