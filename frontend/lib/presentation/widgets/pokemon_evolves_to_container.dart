import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:frontend/presentation/widgets/blurred_image.dart';
import 'package:frontend/presentation/widgets/pokemon_evolution_types.dart';

class PokemonEvolvesToContainer extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonEvolvesToContainer({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    List<Type> strengthTypes = pokemon.getStrengthTypesForPokemon();
    final evolution = context
        .read<PokemonBloc>()
        .state
        .evolutions
        .where((e) => e.pokemonId == pokemon.id)
        .first;
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
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl: strengthTypes[0].imgUrlOutline,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                imageUrl: pokemon.imgUrl,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
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
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Number ${pokemon.id}",
                            style: TextStyle(fontSize: 16),
                          ),
                          PokemonEvolutionTypes(pokemon: pokemon),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 35,
            child:
                evolution.condition != null && evolution.condition!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_downward),
                          Text(evolution.condition!),
                        ],
                      )
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
