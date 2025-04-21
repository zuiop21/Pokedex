import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_circled_type.dart';

//A widget that displays the types of a pokemon
class AdminPokemonTileTypes extends StatelessWidget {
  final int index;
  const AdminPokemonTileTypes({
    super.key,
    required this.index,
  });

  Color getTextColorBasedOnBackground(Color backgroundColor) {
    double red = backgroundColor.r * 255;
    double green = backgroundColor.g * 255;
    double blue = backgroundColor.b * 255;

    double brightness = (red * 0.299 + green * 0.587 + blue * 0.114);

    return brightness > 128 ? Colors.black : Colors.white;
  }

  void _startAddingNewPokemonType(BuildContext context) {
    context.read<AdminBloc>().add(StartAddingPokemonStrengthTypeEvent());
  }

  void _addPokemonType(BuildContext context, Type type) {
    context.read<AdminBloc>().add(AddPokemonStrengthTypeEvent(type: type));
    Navigator.of(context).pop();
  }

  void _stopAddingType(BuildContext context) {
    context.read<AdminBloc>().add(CancelPokemonEvent());
  }

  void _showDialog(BuildContext context) {
    final types = context.read<PokemonBloc>().state.types;
    showDialog(
      context: context,
      builder: (context) => PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            _stopAddingType(context);
          }
        },
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text("Choose a strength type"),
          ),
          content: SizedBox(
            height: 390,
            width: 300,
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.white),
              itemCount: types.length - 1,
              itemBuilder: (context, index) {
                final type = types[index + 1];

                return GestureDetector(
                  onTap: () => _addPokemonType(context, type),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(int.parse(type.color)),
                    ),
                    child: Center(
                      child: Text(
                        type.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: getTextColorBasedOnBackground(
                            Color(int.parse(type.color)),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state.status.isUpdating && state.currentIndex == index) {
            _showDialog(context);
          }
        },
        buildWhen: (previous, current) => !current.status.isPopped,
        builder: (context, state) {
          final pokemon = state.newPokemons[state.currentIndex];
          final strengthTypes = pokemon.types
              .where((t) =>
                  t.isWeakness == WeaknessStatus.both ||
                  t.isWeakness == WeaknessStatus.no)
              .toList();

          return Padding(
            padding: const EdgeInsets.only(bottom: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //First addbutton
                if (strengthTypes.isEmpty)
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.40,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: AppColors.grey, width: 1),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () => _startAddingNewPokemonType(context),
                        icon: const Icon(Icons.add, color: AppColors.grey),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IntrinsicWidth(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(int.parse(strengthTypes[0].color)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            PokemonCircledType(type: strengthTypes[0]),
                            const SizedBox(width: 5),
                            Text(
                              strengthTypes[0].name,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                //Second addbutton
                if (strengthTypes.length == 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(color: AppColors.grey, width: 1),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () => _startAddingNewPokemonType(context),
                          icon: const Icon(Icons.add, color: AppColors.grey),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  )
                else if (strengthTypes.length == 2)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IntrinsicWidth(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(int.parse(strengthTypes[1].color)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            PokemonCircledType(type: strengthTypes[1]),
                            const SizedBox(width: 5),
                            Text(
                              strengthTypes[1].name,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
