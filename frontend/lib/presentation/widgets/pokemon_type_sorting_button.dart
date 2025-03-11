import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/data/models/type.dart';

class PokemonTypeSortingButton extends StatelessWidget {
  const PokemonTypeSortingButton({super.key});

  Color getTextColorBasedOnBackground(Color backgroundColor) {
    double red = backgroundColor.r * 255;
    double green = backgroundColor.g * 255;
    double blue = backgroundColor.b * 255;

    double brightness = (red * 0.299 + green * 0.587 + blue * 0.114);

    return brightness > 128 ? Colors.black : Colors.white;
  }

  void _dropdownCallback(BuildContext context, String? value) {
    context
        .read<PokemonBloc>()
        .add(SortPokemonByTypeEvent(dropDownValue: value!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        return DropdownButton2(
          dropdownStyleData: DropdownStyleData(
              offset: Offset.fromDirection(0, -2),
              direction: DropdownDirection.right,
              width: MediaQuery.of(context).size.width * 0.89,
              maxHeight: MediaQuery.of(context).size.height * 0.62),
          value: state.dropDownValue1,
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
                color: Color(int.parse(state.types
                    .firstWhere((t) => t.name == state.dropDownValue1)
                    .color)),
                borderRadius: BorderRadius.circular(30)),
          ),
          isExpanded: true,
          alignment: AlignmentDirectional.center,
          items: state.types.map<DropdownMenuItem<String>>(
            (Type type) {
              return DropdownMenuItem<String>(
                value: type.name,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(int.parse(type.color)),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    type.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: getTextColorBasedOnBackground(
                        Color(
                          int.parse(type.color),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
          onChanged: (String? value) => _dropdownCallback(context, value),
          underline: Container(),
          iconStyleData: IconStyleData(
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
        );
      },
    );
  }
}
