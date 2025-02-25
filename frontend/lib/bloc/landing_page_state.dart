part of 'landing_page_bloc.dart';

final class LandingPageState extends Equatable {
  final int page;

  final List<String> buttonTexts = [
    "Continue",
    "Let's get started",
  ];
  LandingPageState({required this.page});

  @override
  List<Object?> get props => [page, buttonTexts];
}

final class LandingPageInitial extends LandingPageState {
  LandingPageInitial() : super(page: 0);
}
