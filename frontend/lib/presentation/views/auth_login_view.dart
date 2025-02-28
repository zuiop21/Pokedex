import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/cubit/auth_textfield_cubit.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/auth_page.dart';
import 'package:frontend/presentation/widgets/email_textfield.dart';
import 'package:frontend/presentation/widgets/password_textfield.dart';

class AuthLoginView extends StatefulWidget {
  const AuthLoginView({super.key});

  @override
  State<AuthLoginView> createState() => _AuthLoginViewState();
}

class _AuthLoginViewState extends State<AuthLoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  void _textFieldValueChangedListener() {
    context
        .read<AuthTextfieldCubit>()
        .validateForm(_emailController.text, _passwordController.text);
  }

  void _handleLogin() {
    Navigator.of(context).pushNamed("/auth/login/load");
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailController.addListener(_textFieldValueChangedListener);
    _passwordController = TextEditingController();
    _passwordController.addListener(_textFieldValueChangedListener);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      title: "Welcome back!",
      subTitle: "Fill in your data",
      child1: EmailTextField(
        label: "E-Mail",
        controller: _emailController,
      ),
      child2: PasswordTextField(
        label: "Password",
        controller: _passwordController,
      ),
      child3: TextButton(
          onPressed: () {},
          child: Text(
            "Forgot your password?",
            style: TextStyle(color: AppColors.blue, fontSize: 18),
          )),
      onPressed: _handleLogin,
    );
  }
}
