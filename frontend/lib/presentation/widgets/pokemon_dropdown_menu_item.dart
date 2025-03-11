import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class PokemonDropdownMenuItem extends DropdownMenuItem<String> {
  PokemonDropdownMenuItem({super.key, required String value})
      : super(
          value: value,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.lightBlack,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
}
