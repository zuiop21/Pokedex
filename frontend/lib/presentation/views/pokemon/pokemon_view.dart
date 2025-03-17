import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/cubit/pokemon_bottom_nav_bar_cubit.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/pokemon_favourite_page.dart';
import 'package:frontend/presentation/pages/pokemon_list_page.dart';
import 'package:frontend/presentation/pages/pokemon_region_page.dart';
import 'package:frontend/presentation/widgets/pokemon_search_bar.dart';

class PokemonView extends StatelessWidget {
  const PokemonView({super.key});

  void _onItemTapped(BuildContext context, int index) {
    context.read<PokemonBottomNavBarCubit>().nextPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBottomNavBarCubit, PokemonBottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: switch (state.page) {
            0 => AppBar(
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(1.0),
                  child: Divider(
                    color: AppColors.lightGrey,
                    thickness: 1,
                  ),
                ),
                surfaceTintColor: Colors.transparent,
                toolbarHeight: 80,
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: PokemonSearchBar(),
                ),
              ),
            1 => AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(1.0),
                  child: Divider(
                    color: AppColors.lightGrey,
                    thickness: 1,
                  ),
                ),
                automaticallyImplyLeading: false,
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Regions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                toolbarHeight: 80,
              ),
            2 => AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(1.0),
                  child: Divider(
                    color: AppColors.lightGrey,
                    thickness: 1,
                  ),
                ),
                automaticallyImplyLeading: false,
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Favourites",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                toolbarHeight: 80,
              ),
            _ => AppBar(
                automaticallyImplyLeading: false,
              )
          },
          body: switch (state.page) {
            0 => PokemonListPage(),
            1 => PokemonRegionPage(),
            2 => PokemonFavouritePage(),
            _ => Center(child: Text("Invalid page index")),
          },
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.page,
            selectedFontSize: 16,
            selectedItemColor: AppColors.blue,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                  activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(AppAssets.pokedexSelect),
                  ),
                  icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(AppAssets.pokedexUnselect),
                  ),
                  label: 'Pokédex'),
              BottomNavigationBarItem(
                  activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(AppAssets.regionsSelect),
                  ),
                  icon: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(AppAssets.regionsUnselect)),
                  label: 'Regions'),
              BottomNavigationBarItem(
                  activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(AppAssets.favouritesSelect),
                  ),
                  icon: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(AppAssets.favouritesUnselect)),
                  label: 'Favourites'),
            ],
            onTap: (index) => _onItemTapped(context, index),
          ),
        );
      },
    );
  }
}
