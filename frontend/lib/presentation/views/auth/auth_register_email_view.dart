import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/cubit/auth_textfield_cubit.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/other/email_textfield.dart';
import 'package:frontend/presentation/widgets/other/flow_button.dart';

//The view to register with email
class AuthRegisterEmailView extends StatefulWidget {
  const AuthRegisterEmailView({super.key});

  @override
  State<AuthRegisterEmailView> createState() => _AuthRegisterEmailViewState();
}

class _AuthRegisterEmailViewState extends State<AuthRegisterEmailView> {
  late TextEditingController _emailController;

//Method to listen to the changes in the textfields
  void _textFieldValueChangedListener() {
    context.read<AuthTextfieldCubit>().validateForm(_emailController.text);
  }

//Method to handle the email registration
  void _handleEmailRegister(BuildContext context) {
    Navigator.of(context).pushNamed(
      "/auth/register/password",
      arguments: _emailController.text,
    );
  }

//Initstate method to initialize the text controllers and add listeners
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailController.addListener(_textFieldValueChangedListener);
  }

//Dispose method to dispose the text controllers
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Create account"),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              const Text(
                "Let's get started!",
                style: TextStyle(fontSize: 30, color: AppColors.grey),
              ),
              const Text(
                "What's your E-mail?",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: EmailTextField(
                  label: "E-mail",
                  controller: _emailController,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Please use a valid E-mail address",
                style: TextStyle(color: AppColors.darkGrey, fontSize: 16),
              ),
              const Spacer(),
              BlocBuilder<AuthTextfieldCubit, AuthTextfieldState>(
                builder: (context, state) {
                  return FlowButton(
                    buttonColor: state.textFieldCondition
                        ? AppColors.blue
                        : AppColors.darkWhite,
                    paddingVertical: 10,
                    onPressed: state.textFieldCondition
                        ? () => _handleEmailRegister(context)
                        : () => {},
                    child: AutoSizeText(
                      "Continue",
                      style: TextStyle(
                        fontSize: 22,
                        color: state.textFieldCondition
                            ? Colors.white
                            : AppColors.lightGrey,
                      ),
                      minFontSize: 18,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
