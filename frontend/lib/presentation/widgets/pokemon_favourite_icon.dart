import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/data/models/processed/pokemon.dart';

class PokemonFavouriteIcon extends StatelessWidget {
  final double size;
  final Pokemon pokemon;
  const PokemonFavouriteIcon(
      {super.key, this.size = 40, required this.pokemon});

  void _changeFavouriteStatus(BuildContext context) {
    context.read<PokemonBloc>().add(FavouritePokemonEvent(pokemon: pokemon));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _changeFavouriteStatus(context),
      child: Stack(
        children: [
          Icon(
            size: size,
            Icons.circle_outlined,
            color: Colors.white,
          ),
          SizedBox(
            width: size,
            height: size,
            child: Icon(
              size: size - 5,
              Icons.circle,
              color: Colors.black.withAlpha(77),
            ),
          ),
          SizedBox(
            width: size,
            height: size,
            child: BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) {
                return Icon(
                  size: size - 20,
                  pokemon.isFavourited
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color:
                      pokemon.isFavourited ? AppColors.lightRed : Colors.white,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
