import 'package:flutter/material.dart';

//A widget to display the gender distribution of a pokemon
class PokemonGenderContainer extends StatelessWidget {
  final double gender;

  const PokemonGenderContainer({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
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
                              topLeft: const Radius.circular(30),
                              bottomLeft: const Radius.circular(30),
                              topRight: gender == 1.0
                                  ? const Radius.circular(30)
                                  : Radius.zero,
                              bottomRight: gender == 1.0
                                  ? const Radius.circular(30)
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
                                topRight: const Radius.circular(30),
                                bottomRight: const Radius.circular(30),
                                topLeft: gender == 0.0
                                    ? const Radius.circular(30)
                                    : Radius.zero,
                                bottomLeft: gender == 0.0
                                    ? const Radius.circular(30)
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
                      const Icon(Icons.male, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text(
                        "${(gender * 100).toStringAsFixed(1)}%",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${((1 - gender) * 100).toStringAsFixed(1)}%",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.female, color: Colors.pink),
                    ],
                  ),
                ],
              )
            : const Align(
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
