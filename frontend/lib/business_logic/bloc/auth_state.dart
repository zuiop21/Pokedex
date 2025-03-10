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
  final User? user;
  final String? error;

  const AuthState({
    this.error,
    this.status = AuthStatus.initial,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, error];
}
