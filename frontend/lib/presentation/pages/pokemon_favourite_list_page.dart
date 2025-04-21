import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_favourite_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonFavouriteListPage extends StatelessWidget {
  final List<Pokemon> favourites;

  const PokemonFavouriteListPage({super.key, required this.favourites});

  void _changeFavouriteStatus(BuildContext context, Pokemon pokemon) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;
    context
        .read<PokemonBloc>()
        .add(FavouriteEvent(pokemon: pokemon, token: token));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(color: Colors.white),
      itemCount: favourites.length,
      itemBuilder: (context, index) {
        return PokemonFavouriteTile(
          actions: [
            CustomSlidableAction(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              autoClose: true,
              onPressed: (context) =>
                  _changeFavouriteStatus(context, favourites[index]),
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.delete,
                size: 45,
              ),
            ),
          ],
          pokemonId: favourites[index].id,
        );
      },
    );
  }
}
