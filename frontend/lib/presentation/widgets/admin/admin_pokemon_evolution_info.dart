import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/admin/admin_pokemon_evolves_to_button.dart';
import 'package:frontend/presentation/widgets/admin/admin_pokemon_evolves_to_container.dart';

//A widget that displays the evolutions of a pokemon
class AdminPokemonEvolutionInfo extends StatelessWidget {
  const AdminPokemonEvolutionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Evolutions",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.lightGrey, width: 1),
            color: Colors.white,
          ),
          child: BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              final pokemons = state.newPokemons;
              final currentIndex = state.currentIndex == 0;
              return GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  childAspectRatio: 2.5,
                ),
                itemCount: currentIndex ? pokemons.length + 1 : pokemons.length,
                itemBuilder: (context, index) {
                  if (currentIndex) {
                    return index == pokemons.length
                        ? AdminPokemonEvolvesToButton(
                            index: index,
                          )
                        : AdminPokemonEvolvesToContainer(
                            index: index,
                          );
                  } else {
                    return AdminPokemonEvolvesToContainer(
                      index: index,
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
