import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
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
    context
        .read<AdminBloc>()
        .add(DeletePokemonByIdEvent(pokemon: pokemon, token: token));
  }

  void _showDialog(BuildContext context, bool success, String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: success ? const Text("Success") : const Text("Failure"),
          content: success
              ? Text(msg)
              : Text(context.read<AdminBloc>().state.error ??
                  "Something went wrong"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _createPokemonVisually(BuildContext context) {
    final pokemonList = context.read<AdminBloc>().state.newPokemons;
    final evolutionList = context.read<AdminBloc>().state.newEvolutions;

    context.read<PokemonBloc>().add(CreateNewPokemonEvent(
        pokemons: pokemonList, evolutions: evolutionList));
  }

  void _deletePokemonVisually(BuildContext context, Pokemon pokemon) {
    context.read<PokemonBloc>().add(DeletePokemonEvent(pokemon: pokemon));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          _showDialog(context, false, "");
        }
        if (state.status.isCreated) {
          _createPokemonVisually(context);
          _showDialog(context, true, "Pokemon created successfully");
        }
        if (state.status.isDeleted) {
          _deletePokemonVisually(context, state.deletedPokemon!);
          _showDialog(context, true, "Pokemon deleted successfully");
        }
      },
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            const Divider(color: Colors.white),
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
      ),
    );
  }
}
