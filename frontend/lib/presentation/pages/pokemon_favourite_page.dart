import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/presentation/pages/pokemon_empty_favourite_page.dart';
import 'package:frontend/presentation/pages/pokemon_favourite_list_page.dart';

class PokemonFavouritePage extends StatelessWidget {
  const PokemonFavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            final favourites = state.findFavouritedPokemons();
            return favourites.isEmpty
                ? const PokemonEmptyFavouritePage()
                : PokemonFavouriteListPage(favourites: favourites);
          },
        ));
  }
}
