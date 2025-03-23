import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/auth_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_search_bar.dart';

class PokemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int page;
  const PokemonAppBar({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Divider(
          color: AppColors.lightGrey,
          thickness: 1,
        ),
      ),
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      title: switch (page) {
        0 => const Padding(
            padding: EdgeInsets.all(10.0),
            child: PokemonSearchBar(),
          ),
        1 => const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Regions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ),
        2 => const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Favourites",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
        3 => Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: AppColors.grey, width: 1),
                    color: Colors.white,
                  ),
                  child: IconButton(
                      onPressed: () {}, //TODO
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: AppColors.grey,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    context.read<AuthBloc>().state.user!.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
        4 => Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Administration",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
        _ => null,
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
