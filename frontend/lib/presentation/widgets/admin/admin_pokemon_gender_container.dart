import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/presentation/widgets/other/edge_to_edge_track_shape.dart';

//A widget to display the gender distribution of a pokemon
class AdminPokemonGenderContainer extends StatelessWidget {
  final int index;
  const AdminPokemonGenderContainer({super.key, required this.index});

  void _changeGender(BuildContext context, double newValue) {
    context.read<AdminBloc>().add(EditPokemonGenderEvent(gender: newValue));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      buildWhen: (previous, current) => !current.status.isPopped,
      builder: (context, state) {
        final pokemon = state.newPokemons[index];
        return Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Gender",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: SizedBox(
                height: 20,
                width: double.infinity,
                child: pokemon.gender >= 0
                    ? SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 15,
                          trackShape: EdgeToEdgeTrackShape(),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15),
                        ),
                        child: Slider(
                          activeColor: Colors.blue,
                          inactiveColor: Colors.pink,
                          value: pokemon.gender,
                          onChanged: (value) => _changeGender(context, value),
                          min: 0.0,
                          max: 1.0,
                          divisions: 20,
                        ))
                    : SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 15,
                          trackShape: EdgeToEdgeTrackShape(),
                          thumbShape: SliderComponentShape.noThumb,
                        ),
                        child: Slider(
                          activeColor: Colors.green,
                          inactiveColor: Colors.green,
                          value: 0.0,
                          onChanged: (value) {},
                        ),
                      ),
              ),
            ),
            pokemon.gender >= 0
                ? SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.male, color: Colors.blue),
                            SizedBox(width: 4),
                            Text(
                              "${(pokemon.gender * 100).toStringAsFixed(1)}%",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${((1 - pokemon.gender) * 100).toStringAsFixed(1)}%",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.female, color: Colors.pink),
                          ],
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 30,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "UNKNOWN GENDER",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: pokemon.gender < 0,
                      onChanged: (value) {
                        if (value == null) return;
                        _changeGender(context, value ? -1 : 0);
                      },
                    ),
                  ),
                  Text(
                    "Unknown",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
