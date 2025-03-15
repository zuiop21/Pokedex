import 'package:flutter/material.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/presentation/widgets/pokemon_tile.dart';

class PokemonFavouriteListPage extends StatelessWidget {
  final List<Pokemon> favourites;

  const PokemonFavouriteListPage({super.key, required this.favourites});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(color: Colors.white),
      itemCount: favourites.length,
      itemBuilder: (context, index) {
        return PokemonTile(
          pokemon: favourites[index],
        );
      },
    );
  }
}
