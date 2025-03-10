import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/pokemon_tile.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({super.key});

  void _dropdownCallback(String? value) {
    // TODO: Implement the callback function when an item is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 75,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.41,
                height: MediaQuery.of(context).size.width * 0.12,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(30)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(15),
                    isExpanded: true,
                    alignment: AlignmentDirectional.center,
                    dropdownColor: Colors.white,
                    items: [
                      DropdownMenuItem(
                        value: "Option 1",
                        child: Text("Option 1"),
                      ),
                      DropdownMenuItem(
                        value: "Option 2",
                        child: Text("Option 2"),
                      ),
                      DropdownMenuItem(
                        value: "Option 3",
                        child: Text("Option 3"),
                      ),
                    ],
                    onChanged: _dropdownCallback,
                    hint: Text(
                      "All types",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17),
                    ),
                    underline: Container(),
                    icon: Padding(
                      padding: const EdgeInsets.only(
                          right: 10, top: 10, bottom: 10, left: 10),
                      child: const Icon(
                        Icons.arrow_drop_down,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.41,
                height: MediaQuery.of(context).size.width * 0.12,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(30)),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(15),
                    isExpanded: true,
                    alignment: AlignmentDirectional.center,
                    dropdownColor: Colors.white,
                    items: [
                      DropdownMenuItem(
                        value: "Option 1",
                        child: Text("Option 1"),
                      ),
                      DropdownMenuItem(
                        value: "Option 2",
                        child: Text("Option 2"),
                      ),
                      DropdownMenuItem(
                        value: "Option 3",
                        child: Text("Option 3"),
                      ),
                    ],
                    onChanged: _dropdownCallback,
                    hint: Text(
                      "Descending",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17),
                    ),
                    underline: Container(),
                    icon: Padding(
                      padding:
                          const EdgeInsets.only(right: 5, top: 10, bottom: 10),
                      child: const Icon(
                        Icons.arrow_drop_down,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.white),
              itemCount: state.pokemons.length,
              itemBuilder: (context, index) {
                return PokemonTile(
                  pokemon: state.pokemons[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
