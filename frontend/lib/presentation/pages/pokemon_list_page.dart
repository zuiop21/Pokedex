import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/presentation/widgets/pokemon_number_sorting_button.dart';
import 'package:frontend/presentation/widgets/pokemon_type_sorting_button.dart';
import 'package:frontend/presentation/widgets/pokemon_tile.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 75,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.41,
                height: MediaQuery.of(context).size.width * 0.12,
                child: PokemonTypeSortingButton(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.41,
                height: MediaQuery.of(context).size.width * 0.12,
                child: PokemonNumberSortingButton(),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.white),
              itemCount: state.filteredPokemons.length,
              itemBuilder: (context, index) {
                return PokemonTile(
                  pokemon: state.filteredPokemons[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
