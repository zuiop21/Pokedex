import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/pokemon.dart';
import 'package:frontend/presentation/widgets/pokemon_basic_info.dart';
import 'package:frontend/presentation/widgets/pokemon_body_info.dart';
import 'package:frontend/presentation/widgets/pokemon_evolution_info.dart';
import 'package:frontend/presentation/widgets/pokemon_info_appbar.dart';
import 'package:frontend/presentation/widgets/pokemon_weaknesses_grid.dart';

class PokemonInfoView extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonInfoView({super.key, required this.pokemon});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(
                height: 230,
                width: double.infinity,
                child: PokemonInfoAppbar(pokemon: pokemon),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: PokemonBasicInfo(pokemon: pokemon)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Divider(
                          color: AppColors.lightGrey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                            height: 270,
                            width: double.infinity,
                            child: PokemonBodyInfo(pokemon: pokemon)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: PokemonWeaknessesGrid(
                            pokemon: pokemon,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: PokemonEvolutionInfo(pokemon: pokemon),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
