import 'package:bloc_test/bloc_test.dart';
import 'package:frontend/business_logic/cubit/password_visibility_cubit.dart';

void main() {
  blocTest<PasswordVisibilityCubit, PasswordVisibilityState>(
    'emits [updated] when toggling visibility',
    build: () => PasswordVisibilityCubit(),
    act: (PasswordVisibilityCubit cubit) => cubit.toggleVisibility(),
    expect: () => [
      const PasswordVisibilityState(isVisible: false),
    ],
  );
}
