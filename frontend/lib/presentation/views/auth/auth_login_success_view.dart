import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/auth_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/business_logic/cubit/pokemon_bottom_nav_bar_cubit.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/onboarding_page.dart';
import 'package:frontend/presentation/views/loading_view.dart';
import 'package:frontend/presentation/views/pokemon/pokemon_view.dart';
import 'package:frontend/presentation/widgets/flow_button.dart';

class AuthLoginSuccessView extends StatelessWidget {
  const AuthLoginSuccessView({super.key});

  void _handleButtonAction(BuildContext context) {
    final token = context.read<AuthBloc>().state.user!.token;
    context.read<PokemonBloc>().add(GetPokemonEvent(token: token));
  }

  void _showErrorDialog(BuildContext context, String? errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Data Fetch Failed"),
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
    return BlocConsumer<PokemonBloc, PokemonState>(
      listener: (context, state) {
        if (state.status == PokemonStatus.failure) {
          _showErrorDialog(context, state.error);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case PokemonStatus.failure:
          case PokemonStatus.initial:
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  children: [
                    const Spacer(flex: 17),
                    Expanded(
                      flex: 65,
                      child: OnboardingPage(
                        imagePath: AppAssets.trainer7,
                        title: "Welcome back, Trainer!",
                        subtitle:
                            "We hope you have had a long journey since the last time you visited us",
                      ),
                    ),
                    Expanded(
                      flex: 14,
                      child: FlowButton(
                        buttonColor: AppColors.blue,
                        paddingVertical: 30,
                        onPressed: () => _handleButtonAction(context),
                        child: const AutoSizeText(
                          "Continue",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                          minFontSize: 18,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );

          case PokemonStatus.success:
            return BlocProvider(
              create: (context) => PokemonBottomNavBarCubit(),
              child: const PokemonView(),
            );

          case PokemonStatus.loading:
            return const LoadingView();
        }
      },
    );
  }
}
