import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/admin_pokemon_list_page.dart';

class AdminPokemonView extends StatelessWidget {
  const AdminPokemonView({super.key});

  void _navigateToNewPokemonView(BuildContext context) {
    context.read<AdminBloc>().add(StartPokemonCreationEvent(index: 0));
    Navigator.of(context).pushNamed(
      "/admin/pokemons/new",
      arguments: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            color: AppColors.lightGrey,
            thickness: 1,
          ),
        ),
        toolbarHeight: 80,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Pokemons",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: GestureDetector(
              onTap: () => _navigateToNewPokemonView(context),
              child: Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.grey, width: 1),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: AppColors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) {
                final pokemons = state.pokemons.values.toList();
                return AdminPokemonListPage(pokemons: pokemons);
              },
            ),
          ),
        ],
      ),
    );
  }
}
