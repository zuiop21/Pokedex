import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/cubit/landing_page_cubit.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/onboarding_page.dart';
import 'package:frontend/presentation/widgets/other/flow_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//The view that is shown when the user is onboarding
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;

//Initstate method to initialize the page controller
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

//Dispose method to dispose the page controller
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

//Method to handle the navigation
  void _handleNavigation(BuildContext context, int page) {
    if (page == 0) {
      context.read<LandingPageCubit>().nextPage(1);
    } else {
      Navigator.of(context).pushNamed("/auth/onboarding/option");
    }
  }

  @override
  Widget build(BuildContext context) {
    //! BlocProvider is used to provide the LandingPageCubit to the widget tree
    return BlocProvider(
      create: (context) => LandingPageCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<LandingPageCubit, LandingPageState>(
            listener: (context, state) {
              _pageController.animateToPage(
                state.page,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      SizedBox(
                        height: 540,
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: const [
                            OnboardingPage(
                              title: "All Pokémons in one place",
                              subtitle:
                                  "Access a vast list of Pokémons from every generation ever made by Nintendo",
                              imagePath: AppAssets.trainer2,
                            ),
                            OnboardingPage(
                              title: "Keep your Pokédex up to date",
                              subtitle:
                                  "Register and keep your profile, favourite Pokémons, settings and much more!",
                              imagePath: AppAssets.trainer6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      AnimatedSmoothIndicator(
                        activeIndex: state.page,
                        count: 2,
                        effect: ExpandingDotsEffect(
                          activeDotColor: AppColors.blue,
                          dotColor: AppColors.lightBlue.withAlpha(64),
                        ),
                      ),
                      FlowButton(
                        key: const Key('onboarding_next_button'),
                        buttonColor: AppColors.blue,
                        paddingVertical: 30,
                        onPressed: () => _handleNavigation(context, state.page),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: AutoSizeText(
                            state.buttonTexts[state.page],
                            key:
                                ValueKey<String>(state.buttonTexts[state.page]),
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                            minFontSize: 18,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
