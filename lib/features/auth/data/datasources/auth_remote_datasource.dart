import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatasource {
  final SupabaseClient client;

  AuthRemoteDatasource(this.client);

  Session? currentSession() {
    return client.auth.currentSession;
  }

  Future<bool> isUsernameTaken(String username) async {
    final existing = await client
        .from('users')
        .select('user_id')
        .eq('username', username)
        .maybeSingle();

    return existing != null;
  }

  Future<bool> isPhoneRegistered(String phone) async {
    final existingPhone = await client
        .from('users')
        .select('user_id')
        .eq('phone_no', phone)
        .maybeSingle();

    return existingPhone != null;
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
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
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
        'phone': phone,
        'name': name,
      },
    );

    final user = response.user;

    if (user == null) {
      throw Exception("Failed to create auth user");
    }

    return response;
  }

  Future<void> logout() async {
    await client.auth.signOut();
  }
}