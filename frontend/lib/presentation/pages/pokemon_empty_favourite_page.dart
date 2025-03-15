import 'package:flutter/widgets.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';

class PokemonEmptyFavouritePage extends StatelessWidget {
  const PokemonEmptyFavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Image.asset(AppAssets.magikarp),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            textAlign: TextAlign.center,
            "You haven't liked any Pokémons yet :(",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColors.lightBlack),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            textAlign: TextAlign.center,
            "Click on the heart icon of your favourite Pokémon and they will appear here.",
            style: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 18,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
