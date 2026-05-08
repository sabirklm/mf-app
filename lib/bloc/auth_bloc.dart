import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mf_ip/routes/app_routes.dart';
import 'package:mf_ip/service/auth_service.dart';
import 'package:mf_ip/service/local_storage_service.dart';

import '../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authService = AuthService();
  AuthBloc() : super(AuthState()) {
    on<LoginWithEmailPassword>(_onLoginWithEmailPassword);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginWithEmailPassword(
    LoginWithEmailPassword event,
    Emitter<AuthState> emit,
  ) async {
    try {
      kPrint("Authenticating of ${event.email}");
      emit(AuthState(status: AuthStatus.loading));
      var token = await _authService.login(event.email, event.password);
      if (token != null) {
        await SecureStorageService.instance.write(
          key: SecureStorageService.accessTokenKey,
          value: token,
        );

        emit(AuthState(status: AuthStatus.authenticated));
      } else {
        kPrint("Error authenticating user...");
        emit(AuthState(status: AuthStatus.failure));
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.failure));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    try {
      var toekn = await SecureStorageService.instance.read(
        SecureStorageService.accessTokenKey,
      );
      if (toekn != null) {
        emit(AuthState(status: AuthStatus.authenticated));
      } else {
        emit(AuthState(status: AuthStatus.unauthenticated));
      }
    } catch (e) {
      kPrint("UnAuthenticated...");
    }
  }
}
