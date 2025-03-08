import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/region_tile.dart';

class PokemonRegionView extends StatelessWidget {
  const PokemonRegionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              const Divider(color: Colors.white),
          itemCount: 10,
          itemBuilder: (context, index) {
            return RegionTile();
          },
        ),
      ),
    );
  }
}
