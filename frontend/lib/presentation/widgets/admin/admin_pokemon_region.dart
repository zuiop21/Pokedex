import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/region.dart';

class AdminPokemonRegion extends StatelessWidget {
  final int index;
  const AdminPokemonRegion({super.key, required this.index});

  void _startAddingRegion(BuildContext context) {
    context.read<AdminBloc>().add(StartAddingPokemonRegionEvent());
  }

  void _addRegion(BuildContext context, Region region) {
    context.read<AdminBloc>().add(AddPokemonRegionEvent(region: region));
    Navigator.of(context).pop();
  }

  void _stopAddingRegion(BuildContext context) {
    context.read<AdminBloc>().add(CancelPokemonEvent());
  }

  void _showDialog(BuildContext context) {
    final regions = context.read<PokemonBloc>().state.regions;
    showDialog(
      context: context,
      builder: (context) => PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            _stopAddingRegion(context);
          }
        },
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text("Choose which region your pokemon is from"),
          ),
          content: SizedBox(
            height: 390,
            width: 300,
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.white),
              itemCount: regions.length,
              itemBuilder: (context, index) {
                final region = regions[index];

                return GestureDetector(
                  onTap: () => _addRegion(context, region),
                  child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.amber, //todo
                      ),
                      child: Center(child: Text(region.name))), //todo
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
      buildWhen: (previous, current) => !current.status.isPopped,
      listener: (context, state) {
        if (state.status.isAdding && state.currentIndex == index) {
          _showDialog(context);
        }
      },
      builder: (context, state) {
        final pokemon = state.newPokemons[state.currentIndex];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Region",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (pokemon.regionId == -1)
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.grey, width: 1),
                  color: Colors.white,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () => _startAddingRegion(context),
                    icon: const Icon(Icons.add, color: AppColors.grey),
                    padding: EdgeInsets.zero,
                  ),
                ),
              )
            else
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.grey, width: 1),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        context
                            .read<PokemonBloc>()
                            .state
                            .regions
                            .firstWhere(
                                (region) => region.id == pokemon.regionId)
                            .name,
                        style: const TextStyle(color: AppColors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.grey, width: 1),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () => _startAddingRegion(context),
                          icon: const Icon(Icons.add, color: AppColors.grey),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  )
                ],
              )
          ],
        );
      },
    );
  }
}
