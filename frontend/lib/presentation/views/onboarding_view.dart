import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bloc/landing_page_bloc.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/onboarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingPageBloc(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LandingPageBloc, LandingPageState>(
            listener: (context, state) {
              _pageController.animateToPage(
                state.page,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(flex: 13, child: Container()),
                  Expanded(
                    flex: 65,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: [
                        OnboardingPage(
                          title: "All Pokémons in one place",
                          subtitle:
                              "Access a vast list of Pokémons from every generation ever made by Nintendo",
                          imagePath: AppAssets.trainer2,
                          flexImage: 70,
                          flexText: 30,
                        ),
                        OnboardingPage(
                          title: "Keep your Pokédex up to date",
                          subtitle:
                              "Register and keep your profile, favourite Pokémons, settings and much more!",
                          imagePath: AppAssets.trainer6,
                          flexImage: 70,
                          flexText: 30,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedSmoothIndicator(
                        activeIndex: state.page,
                        count: 2,
                        effect: ExpandingDotsEffect(
                          activeDotColor: AppColors.blue,
                          dotColor: AppColors.lightGrey.withAlpha(64),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 14,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            if (state.page == 0) {
                              context
                                  .read<LandingPageBloc>()
                                  .add(LandingPageEvent(page: 1));
                            } else {
                              Navigator.of(context)
                                  .pushNamed("/auth/onboarding");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: AutoSizeText(
                              state.buttonTexts[state.page],
                              key: ValueKey<String>(
                                  state.buttonTexts[state.page]),
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white),
                              minFontSize: 18,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
