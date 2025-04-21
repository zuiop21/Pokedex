import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonInfoAppbar extends StatelessWidget {
  final int pokemonId;

  const PokemonInfoAppbar({super.key, required this.pokemonId});

  void _changeFavouriteStatus(BuildContext context, Pokemon pokemon) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;
    context
        .read<PokemonBloc>()
        .add(FavouriteEvent(pokemon: pokemon, token: token));
  }

  void _navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        final pokemon = state.getPokemonById(pokemonId);

        List<Type> strengthTypes = pokemon!.getStrengthTypesForPokemon();

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -MediaQuery.of(context).size.width * 0.6,
              left: -MediaQuery.of(context).size.width * 0.055,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black, Colors.transparent],
                    stops: [0.75, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.1,
                  height: MediaQuery.of(context).size.width * 1.1,
                  decoration: BoxDecoration(
                    color: Color(int.parse(strengthTypes[0].color)),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: () => _navigateBack(context),
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: IconButton(
                icon: Icon(
                  pokemon.isFavourited
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color:
                      pokemon.isFavourited ? AppColors.lightRed : Colors.white,
                ),
                onPressed: () => _changeFavouriteStatus(context, pokemon),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: 135,
                  height: 135,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.5, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: strengthTypes[0].imgUrlOutline.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: strengthTypes[0].imgUrlOutline,
                            fit: BoxFit.contain,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Hero(
                tag: "pokemon-${pokemon.id}",
                child: pokemon.imgUrl.isNotEmpty
                    ? CachedNetworkImage(
                        width: 125,
                        height: 125,
                        imageUrl: pokemon.imgUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : const Icon(Icons.error),
              ),
            ),
          ],
        );
      },
    );
  }
}
