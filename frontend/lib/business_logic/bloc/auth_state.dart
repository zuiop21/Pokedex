part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isLoading => this == AuthStatus.loading;
  bool get isSuccess => this == AuthStatus.success;
  bool get isFailure => this == AuthStatus.failure;
}

final class AuthState extends Equatable {
  final AuthStatus status;
  final User user;

  const AuthState({
    this.status = AuthStatus.initial,
    User? user,
  }) : user = user ?? const User(id: 0, token: "", role: "");

  AuthState copyWith({
    AuthStatus? status,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
