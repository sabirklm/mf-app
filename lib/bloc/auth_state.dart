part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? message;
  final bool isObscure;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.message,
    this.isObscure = true,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? message,
    bool? isObscure,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  List<Object?> get props => [isObscure, status];
}
