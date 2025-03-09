import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/pokemon_tile_types.dart';

class PokemonTile extends StatelessWidget {
  final Color tileColor;
  const PokemonTile({super.key, required this.tileColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, //TODO buttonaction
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
                    color: tileColor.withAlpha(77),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 20,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            "Number",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 30,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("Name",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          )),
                      Expanded(flex: 50, child: PokemonTileTypes())
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
                        color: tileColor.withAlpha(77),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: tileColor,
                      ),
                    ),
                    Center(
                      child: CachedNetworkImage(
                        //TODO blur logo image
                        width: 110,
                        height: 110,
                        imageUrl:
                            "http://localhost:3000/assets/pokemons/magikarp-1741457419608.png",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/full/001.png",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          size: 35,
                          Icons.heart_broken_outlined,
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
