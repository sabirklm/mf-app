part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class LoginWithEmailPassword extends AuthEvent {
  final String email;
  final String password;

  const LoginWithEmailPassword({required this.email, required this.password}); 
}
class CheckAuthStatus extends AuthEvent {}