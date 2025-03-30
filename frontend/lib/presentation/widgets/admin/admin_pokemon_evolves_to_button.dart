import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/constants/app_colors.dart';

//A widget that displays the evolutions of a pokemon
class AdminPokemonEvolvesToButton extends StatelessWidget {
  final int index;
  const AdminPokemonEvolvesToButton({super.key, required this.index});

  void _addAnotherPokemon(BuildContext context) {
    context.read<AdminBloc>().add(StartPokemonCreationEvent(index: index));
    Navigator.of(context).pushNamed(
      "/admin/pokemons/new",
      arguments: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        children: [
          Expanded(
            flex: 65,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: AppColors.lightGrey, width: 1),
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: () => _addAnotherPokemon(context),
                icon: Icon(Icons.add, color: AppColors.grey),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          Spacer(
            flex: 35,
          )
        ],
      ),
    );
  }
}
