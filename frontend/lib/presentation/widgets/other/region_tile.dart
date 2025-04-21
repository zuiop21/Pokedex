import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/region.dart';

//A widget that displays a region
class RegionTile extends StatelessWidget {
  final Region region;
  const RegionTile({super.key, required this.region});

//Navigate to the pokemons view of the region
  void _showPokemonsByRegion(BuildContext context) {
    context.read<PokemonBloc>().add(SortPokemonByRegionEvent(region: region));
    Navigator.of(context).pushNamed("/pokemons", arguments: region.name);
  }

  @override
  Widget build(BuildContext context) {
    //Find the pokemons of the region, that can be found
    final pokemons =
        context.read<PokemonBloc>().state.findBaseFormsByRegion(region);

    return GestureDetector(
      onTap: () => _showPokemonsByRegion(context),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            height: 110,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              region.imgUrl.isNotEmpty
                  ? Positioned.fill(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: region.imgUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : const Icon(Icons.error),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.25, 1.0],
                    colors: [
                      Colors.black.withAlpha(130),
                      AppColors.lightGrey.withAlpha(80),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          region.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22),
                        ),
                        Text(
                          "DIFFICULTY ${region.difficulty}",
                          style: const TextStyle(
                              fontSize: 15, color: AppColors.lightWhite),
                        )
                      ],
                    ),
                    const Spacer(),
                    if (pokemons.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: pokemons[0].imgUrl.isNotEmpty
                              ? CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: pokemons[0].imgUrl,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : const Icon(Icons.error),
                        ),
                      ),
                    if (pokemons.length > 1)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: pokemons[1].imgUrl.isNotEmpty
                              ? CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: pokemons[1].imgUrl,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : const Icon(Icons.error),
                        ),
                      ),
                    if (pokemons.length > 2)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: pokemons[2].imgUrl.isNotEmpty
                              ? CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: pokemons[2].imgUrl,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : const Icon(Icons.error),
                        ),
                      ),
                    const Spacer(),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
