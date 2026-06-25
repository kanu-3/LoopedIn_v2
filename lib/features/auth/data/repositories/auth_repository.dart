import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepository {

  final AuthRemoteDatasource datasource;

  AuthRepository(this.datasource);

  bool isLoggedIn() {
    return SupabaseService.client.auth.currentSession != null;
  }

  Future<bool> isUsernameTaken(
      String username,
      ) {
    return datasource.isUsernameTaken(
      username,
    );
  }

  Future<bool> isPhoneRegistered(
      String phone,
      ){
    return datasource.isPhoneRegistered(phone);
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) {
    return datasource.login(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signup({
    required String username,
    required String phone,
    required String email,
    required String password,
    required String name,
  }) {
    return datasource.signup(
      username: username,
      phone: phone,
      email: email,
      password: password,
      name : name,
    );
  }

  Future<void> logout() {
    return datasource.logout();
  }
}