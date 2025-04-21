import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/business_logic/cubit/pokemon_bottom_nav_bar_cubit.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/onboarding_page.dart';
import 'package:frontend/presentation/views/loading_view.dart';
import 'package:frontend/presentation/views/pokemon/pokemon_view.dart';
import 'package:frontend/presentation/widgets/other/flow_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

//The view that is shown when the registration is successful
class AuthRegisterSuccessView extends StatelessWidget {
  const AuthRegisterSuccessView({super.key});

//Method to handle the button action
  void _handleButtonAction(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token") ?? "";

    if (!context.mounted) return;

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
      buildWhen: (previous, current) {
        return current.status != PokemonStatus.failure;
      },
      builder: (context, state) {
        switch (state.status) {
          case PokemonStatus.failure:
          case PokemonStatus.initial:
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                          stops: [0.3, 0.8],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: FractionallySizedBox(
                        heightFactor: 0.5,
                        widthFactor: 1,
                        child: Icon(
                          color: AppColors.blue.withValues(alpha: 0.2),
                          Icons.check_circle_outline_outlined,
                          size: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const Spacer(flex: 17),
                        const Expanded(
                          flex: 65,
                          child: OnboardingPage(
                              imagePath: AppAssets.trainer8,
                              title:
                                  "Your account has been successfully created!",
                              subtitle:
                                  "Welcome, trainer! We're excited to follow your journey."),
                        ),
                        Expanded(
                          flex: 14,
                          child: FlowButton(
                            buttonColor: AppColors.blue,
                            paddingVertical: 30,
                            onPressed: () => _handleButtonAction(context),
                            child: const AutoSizeText(
                              "Continue",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                              minFontSize: 18,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
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
