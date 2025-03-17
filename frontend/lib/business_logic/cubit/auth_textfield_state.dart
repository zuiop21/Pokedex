part of 'auth_textfield_cubit.dart';

//The state of the AuthTextfieldCubit
final class AuthTextfieldState extends Equatable {
  final bool textFieldCondition;

  const AuthTextfieldState({required this.textFieldCondition});
  @override
  List<Object?> get props => [textFieldCondition];
}

final class AuthTextfieldInitial extends AuthTextfieldState {
  const AuthTextfieldInitial() : super(textFieldCondition: false);
}
