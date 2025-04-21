import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_dropdown_menu_item.dart';

//A widget that displays a dropdown button for sorting the pokemon by id
class PokemonIdSortingButton extends StatelessWidget {
  const PokemonIdSortingButton({super.key});

  //Callback function for the dropdown
  void _dropdownCallback(BuildContext context, String? value) {
    context
        .read<PokemonBloc>()
        .add(OrderPokemonByIdEvent(dropDownValue: value!));
  }

  @override
  Widget build(BuildContext context) {
    //! BlocBuilder is used to rebuild the widget when the state changes
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
          iconStyleData: const IconStyleData(
            icon: Padding(
              padding: EdgeInsets.only(right: 5, top: 10, bottom: 10),
              child: Icon(
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
