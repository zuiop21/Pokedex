import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/region.dart';

class RegionTile extends StatelessWidget {
  final Region region;
  const RegionTile({super.key, required this.region});

  void _showPokemonsByRegion(BuildContext context) {
    context.read<PokemonBloc>().add(SortPokemonByRegionEvent(region: region));
    Navigator.of(context).pushNamed("/pokemons");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPokemonsByRegion(context),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            height: 110,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: region.imgUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.2, 1.0],
                    colors: [
                      Colors.black.withAlpha(130),
                      AppColors.lightGrey.withAlpha(80),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          region.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22),
                        ),
                        Text(
                          "DIFFICULTY ${region.difficulty}",
                          style: TextStyle(
                              fontSize: 15, color: AppColors.lightWhite),
                        )
                      ],
                    ),
                    Spacer(
                      flex: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.circle,
                        size: 50,
                      ),
                    ),
                    Icon(
                      Icons.circle,
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.circle,
                        size: 50,
                      ),
                    ),
                    Spacer(),
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
