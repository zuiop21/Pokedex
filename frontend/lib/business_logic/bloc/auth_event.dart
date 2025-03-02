part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  final String email;
  final String password;

  const AuthEvent({required this.email, required this.password});

  @override
  List<Object?> get props => throw UnimplementedError();
}

final class LoginEvent extends AuthEvent {
  const LoginEvent({required super.email, required super.password});
}

final class RegisterEvent extends AuthEvent {
  const RegisterEvent({required super.email, required super.password});
}
