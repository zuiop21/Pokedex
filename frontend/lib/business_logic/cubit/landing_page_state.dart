part of 'landing_page_cubit.dart';

//The state of the LandingPageCubit
class LandingPageState extends Equatable {
  final int page;

  //Helper list for the button texts
  final List<String> buttonTexts = [
    "Continue",
    "Let's get started",
  ];

  LandingPageState({required this.page});

  @override
  List<Object?> get props => [page, buttonTexts];
}

class LandingPageInitial extends LandingPageState {
  LandingPageInitial() : super(page: 0);
}
