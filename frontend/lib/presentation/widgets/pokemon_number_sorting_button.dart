import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/pokemon_dropdown_menu_item.dart';

class PokemonNumberSortingButton extends StatelessWidget {
  const PokemonNumberSortingButton({super.key});

  void _dropdownCallback(BuildContext context, String? value) {
    context
        .read<PokemonBloc>()
        .add(OrderPokemonByNumberEvent(dropDownValue: value!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        return DropdownButton2(
          dropdownStyleData: DropdownStyleData(
              offset: Offset.fromDirection(0, 2),
              direction: DropdownDirection.left,
              width: MediaQuery.of(context).size.width * 0.89,
              maxHeight: MediaQuery.of(context).size.height * 0.62),
          value: state.dropDownValue2,
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
                color: AppColors.lightBlack,
                borderRadius: BorderRadius.circular(30)),
          ),
          isExpanded: true,
          alignment: AlignmentDirectional.center,
          items: [
            PokemonDropdownMenuItem(value: "Ascending"),
            PokemonDropdownMenuItem(value: "Descending"),
            PokemonDropdownMenuItem(value: "A-Z"),
            PokemonDropdownMenuItem(value: "Z-A"),
          ],
          onChanged: (String? value) => _dropdownCallback(context, value),
          underline: Container(),
          iconStyleData: IconStyleData(
            icon: Padding(
              padding: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
              child: const Icon(
                Icons.arrow_drop_down,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
