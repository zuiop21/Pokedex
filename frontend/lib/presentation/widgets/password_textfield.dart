import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/cubit/password_visibility_cubit.dart';
import 'package:frontend/constants/app_colors.dart';

class PasswordTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const PasswordTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  void _handlePasswordVisibility(BuildContext context) {
    context.read<PasswordVisibilityCubit>().toggleVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordVisibilityCubit(),
      child: BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              TextFormField(
                controller: controller,
                obscureText: state.isVisible,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide:
                        BorderSide(color: AppColors.lightGrey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  hintText: label,
                  hintStyle:
                      TextStyle(color: AppColors.lightGrey, fontSize: 20),
                  suffixIcon: GestureDetector(
                    onTap: () => _handlePasswordVisibility(context),
                    child: Icon(
                      state.isVisible ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
