import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/auth_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/business_logic/cubit/pokemon_bottom_nav_bar_cubit.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/pokemon_admin_page.dart';
import 'package:frontend/presentation/pages/pokemon_favourite_page.dart';
import 'package:frontend/presentation/pages/pokemon_list_page.dart';
import 'package:frontend/presentation/pages/pokemon_region_page.dart';
import 'package:frontend/presentation/pages/pokemon_user_page.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_appbar.dart';

class PokemonView extends StatelessWidget {
  const PokemonView({super.key});

  void _onItemTapped(BuildContext context, int index) {
    context.read<PokemonBottomNavBarCubit>().nextPage(index);
    context.read<PokemonBloc>().add(ResetSearchBarEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBottomNavBarCubit, PokemonBottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PokemonAppBar(page: state.page),
          body: switch (state.page) {
            0 => const PokemonListPage(),
            1 => const PokemonRegionPage(),
            2 => const PokemonFavouritePage(),
            3 => const PokemonUserPage(),
            4 => const PokemonAdminPage(),
            _ => const Center(child: Text("Invalid page index")),
          },
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state.page,
            selectedFontSize: 16,
            selectedItemColor: AppColors.blue,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                activeIcon:
                    Image.asset(AppAssets.pokedexSelect, width: 40, height: 40),
                icon: Image.asset(AppAssets.pokedexUnselect,
                    width: 40, height: 40),
                label: 'Pokédex',
              ),
              BottomNavigationBarItem(
                activeIcon:
                    Image.asset(AppAssets.regionsSelect, width: 40, height: 40),
                icon: Image.asset(AppAssets.regionsUnselect,
                    width: 40, height: 40),
                label: 'Regions',
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(AppAssets.favouritesSelect,
                    width: 40, height: 40),
                icon: Image.asset(AppAssets.favouritesUnselect,
                    width: 40, height: 40),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                activeIcon:
                    Image.asset(AppAssets.userSelect, width: 40, height: 40),
                icon:
                    Image.asset(AppAssets.userUnselect, width: 40, height: 40),
                label: 'Account',
              ),

              //Show this extra navbaritem if the user is an admin or superadmin
              if (context.read<AuthBloc>().state.user!.role == "admin" ||
                  context.read<AuthBloc>().state.user!.role == "super")
                BottomNavigationBarItem(
                  activeIcon:
                      Image.asset(AppAssets.adminSelect, width: 48, height: 48),
                  icon: Image.asset(AppAssets.adminUnselect,
                      width: 48, height: 48),
                  label: 'Admin',
                ),
            ],
            onTap: (index) => _onItemTapped(context, index),
          ),
        );
      },
    );
  }
}
