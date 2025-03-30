import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_circled_type.dart';

//A widget that displays the weaknesses of a pokemon
class AdminPokemonWeaknessesGrid extends StatelessWidget {
  final int index;
  const AdminPokemonWeaknessesGrid({super.key, required this.index});

  Color getTextColorBasedOnBackground(Color backgroundColor) {
    double red = backgroundColor.r * 255;
    double green = backgroundColor.g * 255;
    double blue = backgroundColor.b * 255;

    double brightness = (red * 0.299 + green * 0.587 + blue * 0.114);

    return brightness > 128 ? Colors.black : Colors.white;
  }

  void _startAddingNewPokemonType(BuildContext context) {
    context.read<AdminBloc>().add(StartAddingPokemonWeaknessTypeEvent());
  }

  void _addPokemonType(BuildContext context, Type type) {
    context
        .read<AdminBloc>()
        .add(AddPokemonWeaknessTypeEvent(type: type, index: index));
    Navigator.of(context).pop();
  }

  void _stopAddingType(BuildContext context) {
    context.read<AdminBloc>().add(StopAddingPokemonTypeEvent());
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
            child: Text("Choose a weakness type"),
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
      buildWhen: (previous, current) => !current.status.isDeleted,
      listener: (context, state) {
        if (state.status.isCreating && state.currentIndex == index) {
          _showDialog(context);
        }
      },
      builder: (context, state) {
        final pokemon = state.newPokemons[state.currentIndex];
        final weaknessTypes = pokemon.types
            .where((t) =>
                t.isWeakness == WeaknessStatus.both ||
                t.isWeakness == WeaknessStatus.yes)
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Weaknesses",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (weaknessTypes.isEmpty)
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
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
                    icon: Icon(Icons.add, color: AppColors.grey),
                    padding: EdgeInsets.zero,
                  ),
                ),
              )
            else
              GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3.5,
                ),
                itemCount: weaknessTypes.length + 1,
                itemBuilder: (context, index) {
                  if (index == weaknessTypes.length) {
                    return Container(
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
                          icon: Icon(Icons.add, color: AppColors.grey),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    );
                  }
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(int.parse(weaknessTypes[index].color)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PokemonCircledType(type: weaknessTypes[index]),
                        const SizedBox(width: 5),
                        Text(
                          weaknessTypes[index].name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
