import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/presentation/widgets/region_tile.dart';

class PokemonRegionPage extends StatelessWidget {
  const PokemonRegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            final regions = state.regions;

            return ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.white),
              itemCount: regions.length,
              itemBuilder: (context, index) {
                return RegionTile(
                  region: regions[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
