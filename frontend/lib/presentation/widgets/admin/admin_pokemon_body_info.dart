import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/presentation/widgets/admin/admin_pokemon_gender_container.dart';
import 'package:frontend/presentation/widgets/admin/admin_pokemon_info_container.dart';

//A widget that displays some basic information of a pokemon
//Such as the weight, height, category and ability
class AdminPokemonBodyInfo extends StatefulWidget {
  final int index;
  const AdminPokemonBodyInfo({super.key, required this.index});

  @override
  State<AdminPokemonBodyInfo> createState() => _AdminPokemonBodyInfoState();
}

class _AdminPokemonBodyInfoState extends State<AdminPokemonBodyInfo> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _abilityController = TextEditingController();

  void _changeWeight(BuildContext context) {
    final weight = double.tryParse(_weightController.text);
    if (weight != null) {
      context.read<AdminBloc>().add(EditPokemonWeightEvent(
            weight: weight,
          ));
    }
  }

  void _changeHeight(BuildContext context) {
    final height = double.tryParse(_heightController.text);
    if (height != null) {
      context.read<AdminBloc>().add(EditPokemonHeightEvent(
            height: height,
          ));
    }
  }

  void _changeCategory(BuildContext context) {
    final category = _categoryController.text;
    context.read<AdminBloc>().add(EditPokemonCategoryEvent(category: category));
  }

  void _changeAbility(BuildContext context) {
    final ability = _abilityController.text;
    context.read<AdminBloc>().add(EditPokemonAbilityEvent(ability: ability));
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _categoryController.dispose();
    _abilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 40,
          child: Row(
            children: [
              AdminPokemonInfoContainer(
                controller: _weightController,
                function: () => _changeWeight(context),
                padding: EdgeInsets.only(right: 5),
                hintText: "12.3 kg",
                icon: Icons.line_weight,
                dataName: "Weight",
              ),
              AdminPokemonInfoContainer(
                controller: _heightController,
                function: () => _changeHeight(context),
                padding: EdgeInsets.only(left: 5),
                hintText: "1.2 m",
                icon: Icons.height,
                dataName: "Height",
              ),
            ],
          ),
        ),
        Expanded(
          flex: 40,
          child: Row(
            children: [
              AdminPokemonInfoContainer(
                controller: _categoryController,
                function: () => _changeCategory(context),
                padding: EdgeInsets.only(right: 5),
                hintText: "Cat",
                icon: Icons.category,
                dataName: "Category",
              ),
              AdminPokemonInfoContainer(
                controller: _abilityController,
                function: () => _changeAbility(context),
                padding: EdgeInsets.only(left: 5),
                hintText: "Meow",
                icon: Icons.accessibility,
                dataName: "Ability",
              ),
            ],
          ),
        ),
        Expanded(
          flex: 55,
          child: AdminPokemonGenderContainer(
            index: widget.index,
          ),
        )
      ],
    );
  }
}
