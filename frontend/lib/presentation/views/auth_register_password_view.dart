import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/cubit/auth_textfield_cubit.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/auth_page.dart';
import 'package:frontend/presentation/widgets/password_textfield.dart';

class AuthRegisterPasswordView extends StatefulWidget {
  const AuthRegisterPasswordView({super.key});

  @override
  State<AuthRegisterPasswordView> createState() =>
      _AuthRegisterPasswordViewState();
}

class _AuthRegisterPasswordViewState extends State<AuthRegisterPasswordView> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  void _textFieldValueChangedListener() {
    context.read<AuthTextfieldCubit>().validateForm(
        _passwordController.text, _confirmPasswordController.text);
  }

  void _handlePasswordRegister() {
    Navigator.of(context).pushNamed("/auth/register/load");
  }

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordController.addListener(_textFieldValueChangedListener);
    _confirmPasswordController = TextEditingController();
    _confirmPasswordController.addListener(_textFieldValueChangedListener);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      title: "Now...",
      subTitle: "Choose a password",
      child1: PasswordTextField(
        label: "Password",
        controller: _passwordController,
      ),
      child2: PasswordTextField(
        label: "Confirm Password",
        controller: _confirmPasswordController,
      ),
      child3: const Text(
        "Your password must be at least 8 characters",
        style: TextStyle(color: AppColors.darkGrey, fontSize: 16),
      ),
      onPressed: _handlePasswordRegister,
    );
  }
}
