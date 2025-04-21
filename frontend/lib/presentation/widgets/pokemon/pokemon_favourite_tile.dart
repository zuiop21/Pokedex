import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_tile_types.dart';

//A widget that displays a favourite pokemon
class PokemonFavouriteTile extends StatelessWidget {
  final int pokemonId;
  const PokemonFavouriteTile(
      {super.key, required this.pokemonId, required this.actions});

  final List<CustomSlidableAction> actions;

  @override
  Widget build(BuildContext context) {
    //Find the pokemon by it's id
    final pokemon = context.read<PokemonBloc>().state.getPokemonById(pokemonId);
    final strengths = pokemon!.getStrengthTypesForPokemon();
    return Slidable(
      endActionPane: ActionPane(
          extentRatio: 0.30, motion: const StretchMotion(), children: actions),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            height: 110,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      color: Color(int.parse(strengths[0].color)).withAlpha(77),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              "Number ${pokemon.id}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 30,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(pokemon.name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            )),
                        Expanded(
                          flex: 40,
                          child: PokemonTileTypes(
                            pokemonId: pokemon.id,
                            leftPadding: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Color(int.parse(strengths[0].color))
                              .withAlpha(77),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(int.parse(strengths[0].color))),
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [0.5, 1.0],
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.dstIn,
                              child: strengths[0].imgUrlOutline.isNotEmpty
                                  ? CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: strengths[0].imgUrlOutline,
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Hero(
                            tag: "pokemon-${pokemon.id}",
                            child: pokemon.imgUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: pokemon.imgUrl,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
