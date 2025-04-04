import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/admin/admin_pokemon_appbar.dart';
import 'package:frontend/presentation/widgets/admin/admin_pokemon_body_info.dart';
import 'package:frontend/presentation/widgets/admin/admin_pokemon_evolution_info.dart';
import 'package:frontend/presentation/widgets/admin/admin_pokemon_weaknesses_grid.dart';
import '../../widgets/admin/admin_pokemon_basic_info.dart';

class AdminNewPokemonView extends StatelessWidget {
  final int index;
  const AdminNewPokemonView({super.key, required this.index});

  void _saveChanges(BuildContext context) {
    if (index == 0) {
      //Todo: SAVE changed/SEND HTTP
    }
    context.read<AdminBloc>().add(CancelActionEvent());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state.newPokemons.isNotEmpty) print(state.newPokemons[0]);

          if (state.newPokemons.length == 2) print(state.newPokemons[1]);
          return Column(
            children: [
              SizedBox(
                height: 230,
                width: double.infinity,
                child: AdminPokemonAppbar(
                  index: index,
                ),
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
                            child: AdminPokemonBasicInfo(
                              index: index,
                            )),
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
                            height: 330,
                            width: double.infinity,
                            child: AdminPokemonBodyInfo(
                              index: index,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: AdminPokemonWeaknessesGrid(
                            index: index,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: AdminPokemonEvolutionInfo(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () => _saveChanges(context),
                              child: Text("SAVE")),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
