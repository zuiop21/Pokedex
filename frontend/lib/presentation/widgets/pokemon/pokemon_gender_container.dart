import 'package:flutter/material.dart';

//A widget to display the gender distribution of a pokemon
class PokemonGenderContainer extends StatelessWidget {
  final double gender;

  const PokemonGenderContainer({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: gender >= 0
              ? Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          width:
                              MediaQuery.of(context).size.width * 0.9 * gender,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              topRight: gender == 1.0
                                  ? Radius.circular(30)
                                  : Radius.zero,
                              bottomRight: gender == 1.0
                                  ? Radius.circular(30)
                                  : Radius.zero,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                topLeft: gender == 0.0
                                    ? Radius.circular(30)
                                    : Radius.zero,
                                bottomLeft: gender == 0.0
                                    ? Radius.circular(30)
                                    : Radius.zero,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
        ),
        gender >= 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.male, color: Colors.blue),
                      SizedBox(width: 4),
                      Text(
                        "${(gender * 100).toStringAsFixed(1)}%",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${((1 - gender) * 100).toStringAsFixed(1)}%",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.female, color: Colors.pink),
                    ],
                  ),
                ],
              )
            : Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "UNKNOWN GENDER",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
      ],
    );
  }
}
