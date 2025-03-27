part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {}

final class LoginEvent extends AuthEvent {
  LoginEvent({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

final class RegisterEvent extends AuthEvent {
  RegisterEvent({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

final class UploadProfilePictureEvent extends AuthEvent {
  UploadProfilePictureEvent({required this.image, required this.token});

  final File image;
  final String token;
  @override
  List<Object?> get props => [image, token];
}
