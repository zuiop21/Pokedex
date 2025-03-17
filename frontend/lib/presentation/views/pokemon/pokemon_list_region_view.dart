import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/pokemon_list_page.dart';
import 'package:frontend/presentation/widgets/pokemon_search_bar.dart';

class PokemonListRegionView extends StatelessWidget {
  final String regionName;
  const PokemonListRegionView({super.key, required this.regionName});

  void _handleNavigation(BuildContext context) {
    context.read<PokemonBloc>().add(SortPokemonByRegionEvent(region: null));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            toolbarHeight: 125,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Divider(
                color: AppColors.lightGrey,
                thickness: 1,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => _handleNavigation(context),
                        icon: Icon(Icons.arrow_back)),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        regionName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                  ],
                ),
                PokemonSearchBar(),
              ],
            )),
        body: PokemonListPage());
  }
}
