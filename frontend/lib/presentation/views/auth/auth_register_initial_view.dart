import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/auth_bloc.dart';
import 'package:frontend/business_logic/cubit/auth_textfield_cubit.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/auth_page.dart';
import 'package:frontend/presentation/views/loading_view.dart';
import 'package:frontend/presentation/views/auth/auth_register_success_view.dart';
import 'package:frontend/presentation/widgets/password_textfield.dart';

class AuthRegisterInitialView extends StatefulWidget {
  final String email;
  const AuthRegisterInitialView({super.key, required this.email});

  @override
  State<AuthRegisterInitialView> createState() =>
      _AuthRegisterInitialViewState();
}

class _AuthRegisterInitialViewState extends State<AuthRegisterInitialView> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  void _textFieldValueChangedListener() {
    context.read<AuthTextfieldCubit>().validateForm(
        _passwordController.text, _confirmPasswordController.text);
  }

  void _handlePasswordRegister(BuildContext context) {
    context.read<AuthBloc>().add(
        RegisterEvent(email: widget.email, password: _passwordController.text));
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
    //TODO alertdialog
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return switch (state.status) {
          AuthStatus.initial => AuthPage(
              leadingText: "Create account",
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
              onPressed: () => _handlePasswordRegister(context),
            ),
          AuthStatus.loading => LoadingView(),
          AuthStatus.failure => Container(
              color: Colors.red,
              child: Text(state.error!),
            ),
          AuthStatus.success => AuthRegisterSuccessView(),
        };
      },
    );
  }
}
