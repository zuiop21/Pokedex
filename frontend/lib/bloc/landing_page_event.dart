part of 'landing_page_bloc.dart';

final class LandingPageEvent extends Equatable {
  final int page;
  const LandingPageEvent({
    required this.page,
  });
  @override
  List<Object?> get props => [page];
}
