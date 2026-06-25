import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'auth_state.dart';
import '../data/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(const AuthState());

  Future<bool> checkAuthStatus() async {
    final session = SupabaseService.client.auth.currentSession;

    final loggedIn = session != null;

    state = state.copyWith(
      isAuthenticated: loggedIn,
    );

    return loggedIn;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final response = await repository.login(
        email: email,
        password: password,
      );

      final success = response.session != null;

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: success,
        error: success ? null : "Invalid credentials",
      );

      return success;
    } on AuthException catch (e) {
      print("AUTH ERROR: ${e.message}");

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: e.message,
      );

      return false;

    } catch (e,st) {
      print("LOGIN ERROR: $e");
      print(st);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: "Something went wrong",
      );

      return false;
    }
  }

  Future<bool> signup({
    required String username,
    required String phone,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final usernameExists =
      await repository.isUsernameTaken(username);

      if (usernameExists) {
        state = state.copyWith(
          isLoading: false,
          error: 'Username already taken',
        );
        return false;
      }

      final phoneExists =
      await repository.isPhoneRegistered(phone);

      if (phoneExists) {
        state = state.copyWith(
          isLoading: false,
          error: 'Phone already registered',
        );
        return false;
      }

      final response = await repository.signup(
        username: username,
        phone: phone,
        email: email,
        password: password,
        name: name,
      );

      final success = response.user != null;

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: null,
      );

      return success;
    } catch (e, st) {
      print("SIGNUP ERROR: $e");
      print(st);

      state = state.copyWith(
        isLoading: false,
        error: "Signup failed. Please try again.",
      );

      return false;
    }
  }


  Future<void> logout() async {
    await repository.logout();

    state = state.copyWith(
      isAuthenticated: false,
      isLoading: false,
      error: null,
    );
  }
  void clearError() {
    state = state.copyWith(error: null);
  }
}