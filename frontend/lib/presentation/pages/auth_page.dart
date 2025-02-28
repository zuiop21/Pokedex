import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/cubit/auth_textfield_cubit.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/widgets/flow_button.dart';

class AuthPage extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final Widget child3;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  const AuthPage({
    super.key,
    required this.child1,
    required this.child2,
    required this.child3,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Text(
                title,
                style: const TextStyle(fontSize: 30, color: AppColors.grey),
              ),
              Text(
                subTitle,
                style: const TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: child1,
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: child2,
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: child3,
              ),
              const Spacer(),
              BlocBuilder<AuthTextfieldCubit, AuthTextfieldState>(
                builder: (context, state) {
                  return FlowButton(
                    buttonColor: state.textFieldCondition
                        ? AppColors.blue
                        : AppColors.darkWhite,
                    paddingVertical: 10,
                    onPressed: state.textFieldCondition ? onPressed : () {},
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
