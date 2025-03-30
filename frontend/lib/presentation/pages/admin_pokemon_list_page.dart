import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_favourite_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPokemonListPage extends StatelessWidget {
  final List<Pokemon> pokemons;

  const AdminPokemonListPage({super.key, required this.pokemons});

  void _deletePokemon(BuildContext context, Pokemon pokemon) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;
    //TODO Delete event
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(color: Colors.white),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => {}, //TODO
          child: PokemonFavouriteTile(
            actions: [
              CustomSlidableAction(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                autoClose: true,
                onPressed: (context) =>
                    _deletePokemon(context, pokemons[index]),
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.delete,
                  size: 45,
                ),
              ),
            ],
            pokemonId: pokemons[index].id,
          ),
        );
      },
    );
  }
}
