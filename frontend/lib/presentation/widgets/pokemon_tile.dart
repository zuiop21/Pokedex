import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/presentation/widgets/pokemon_favourite_icon.dart';
import 'package:frontend/presentation/widgets/pokemon_tile_types.dart';

//A widget that displays a pokemon
class PokemonTile extends StatelessWidget {
  final int pokemonId;
  const PokemonTile({super.key, required this.pokemonId});

//Navigate to the info view of the pokemon
  void _handleNavigationToInfoView(BuildContext context) {
    Navigator.pushNamed(
      context,
      "/pokemon/info",
      arguments: pokemonId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = context.read<PokemonBloc>().state.getPokemonById(pokemonId);
    return GestureDetector(
      onTap: () => _handleNavigationToInfoView(context),
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    color:
                        Color(int.parse(pokemon!.types[0].color)).withAlpha(77),
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
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 30,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(pokemon.name,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
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
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Color(int.parse(pokemon.types[0].color))
                            .withAlpha(77),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(int.parse(pokemon.types[0].color))),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
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
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: pokemon.types[0].imgUrlOutline,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Hero(
                          tag: "pokemon-${pokemon.id}",
                          child: CachedNetworkImage(
                            imageUrl: pokemon.imgUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: PokemonFavouriteIcon(
                          pokemonId: pokemon.id,
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
    );
  }
}
