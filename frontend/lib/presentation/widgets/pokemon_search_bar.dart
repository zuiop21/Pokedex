import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';

class PokemonSearchBar extends StatelessWidget {
  const PokemonSearchBar({super.key});
//TODO sugesstions

  void _onSearchBarValueChanged(BuildContext context, String? value) {
    context
        .read<PokemonBloc>()
        .add(SortPokemonByNameEvent(searchBarValue: value!));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            searchBarTheme: SearchBarThemeData(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(0),
              shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.focused)) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.black, width: 2),
                    );
                  }
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: AppColors.lightGrey, width: 2),
                  );
                },
              ),
              hintStyle: WidgetStatePropertyAll(
                TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: 20,
                ),
              ),
              textStyle: WidgetStatePropertyAll(
                const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          child: SearchBar(
              hintText: "Search Pokémon...",
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: const Icon(Icons.search, color: AppColors.grey),
              ),
              onChanged: (String value) =>
                  _onSearchBarValueChanged(context, value)),
        ),
      ],
    );
  }
}
