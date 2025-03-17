import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/auth_bloc.dart';
import 'package:frontend/business_logic/cubit/auth_textfield_cubit.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/auth_page.dart';
import 'package:frontend/presentation/views/loading_view.dart';
import 'package:frontend/presentation/views/auth/auth_login_success_view.dart';
import 'package:frontend/presentation/widgets/email_textfield.dart';
import 'package:frontend/presentation/widgets/password_textfield.dart';

//The initial view of the login page
class AuthLoginInitialView extends StatefulWidget {
  const AuthLoginInitialView({super.key});

  @override
  State<AuthLoginInitialView> createState() => _AuthLoginInitialViewState();
}

class _AuthLoginInitialViewState extends State<AuthLoginInitialView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

//Method to listen to the changes in the textfields
  void _textFieldValueChangedListener() {
    context
        .read<AuthTextfieldCubit>()
        .validateForm(_emailController.text, _passwordController.text);
  }

//Method to handle the login
  void _handleLogin(BuildContext context) {
    context.read<AuthBloc>().add(LoginEvent(
        email: _emailController.text, password: _passwordController.text));
  }

//Initstate method to initialize the text controllers and add listeners
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailController.addListener(_textFieldValueChangedListener);
    _passwordController = TextEditingController();
    _passwordController.addListener(_textFieldValueChangedListener);
  }

//Dispose method to dispose the text controllers
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

//Method to show an error dialog
  void _showErrorDialog(BuildContext context, String? errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login Failed"),
        content: Text(errorMessage ?? "Something went wrong"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.failure) {
          _showErrorDialog(context, state.error);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.initial:
          case AuthStatus.failure:
            return AuthPage(
              leadingText: "Login",
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
                ),
              ),
              onPressed: () => _handleLogin(context),
            );

          case AuthStatus.loading:
            return const LoadingView();

          case AuthStatus.success:
            return const AuthLoginSuccessView();
        }
      },
    );
  }
}
