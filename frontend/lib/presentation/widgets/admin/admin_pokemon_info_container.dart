import 'package:flutter/material.dart';

//A widget that displays the information of a pokemon
class AdminPokemonInfoContainer extends StatelessWidget {
  final IconData icon;
  final String dataName;
  final String hintText;
  final EdgeInsets padding;
  final TextEditingController controller;
  final VoidCallback function;
  const AdminPokemonInfoContainer(
      {super.key,
      required this.icon,
      required this.dataName,
      required this.hintText,
      required this.padding,
      required this.controller,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 50,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                Text(
                  dataName,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            TextFormField(
              controller: controller,
              onChanged: (value) => function(),
              style: TextStyle(fontSize: 22),
              cursorHeight: 22,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 22),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: EdgeInsets.all(12.0)),
            ),
          ],
        ),
      ),
    );
  }
}
