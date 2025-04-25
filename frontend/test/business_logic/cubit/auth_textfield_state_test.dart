import 'package:bloc_test/bloc_test.dart';
import 'package:frontend/business_logic/cubit/auth_textfield_cubit.dart';

void main() {
  blocTest(
    "emits [updated] when updating textfield condition",
    build: () => AuthTextfieldCubit(),
    act: (AuthTextfieldCubit cubit) => cubit.validateForm("test", "test"),
    expect: () => [const AuthTextfieldState(textFieldCondition: true)],
  );
}
