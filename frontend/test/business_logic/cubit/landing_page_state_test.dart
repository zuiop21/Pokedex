import 'package:bloc_test/bloc_test.dart';
import 'package:frontend/business_logic/cubit/landing_page_cubit.dart';

void main() {
  blocTest<LandingPageCubit, LandingPageState>(
    'emits [updated] when moving to next page',
    build: () => LandingPageCubit(),
    act: (LandingPageCubit cubit) => cubit.nextPage(1),
    expect: () => [
      LandingPageState(page: 1),
    ],
  );
}
