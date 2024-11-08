import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

class ApiServices {
  late final SupabaseClient supabaseClient;
  ApiServices(this.supabaseClient);

// user register using supabase
  Future<AuthResponse> userRegister(String name, String email, String password,
      String dob, String gender, String bio) async {
    final AuthResponse response = await supabaseClient.auth
        .signUp(email: email, password: password, data: {
      "name": name,
      "dob": dob,
      "gender": gender,
      "bio": bio,
    });
    if (response.user != null) {
      throw Exception('Login failed: ${response.user!.toJson()}');
    }
    log("userRegister : ${response.user!.toJson()}");
    return response;
  }

  // user login using supabase

  Future<AuthResponse> userLogin(String email, String password) async {
    final AuthResponse response = await supabaseClient.auth
        .signInWithPassword(email: email, password: password);
    if (response.user != null) {
      throw Exception('Login failed: ${response.user!.toJson()}');
    }
    log("userLogin : ${response.user!.toJson()}");
    return response;
  }
}
