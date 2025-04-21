import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_circled_type.dart';

//A widget that displays the types of a pokemon's evolution
class AdminPokemonEvolutionTypes extends StatelessWidget {
  final int index;

  const AdminPokemonEvolutionTypes({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    //Find the pokemon by it's id
    final pokemon = context.read<AdminBloc>().state.newPokemons[index];
    final strengthTypes = pokemon.getStrengthTypesForPokemon();
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 30),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(int.parse(strengthTypes[0].color)),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(child: PokemonCircledType(type: strengthTypes[0])),
          ),
          if (strengthTypes.length == 2)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(int.parse(strengthTypes[1].color)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child:
                    Center(child: PokemonCircledType(type: strengthTypes[1])),
              ),
            ),
        ],
      ),
    );
  }
}
