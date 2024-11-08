import 'package:flutter/cupertino.dart';
import 'package:social_media/services/api_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends ChangeNotifier {
  late final ApiServices apiServices;
  bool _isLoading = false;
  String? _errorMessage;
  RegisterController(this.apiServices);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  //  for register
  Future<void> register(String name, String email, String password, String dob,
      String gender, String bio) async {
    _setLoading(true);
    try {
      final AuthResponse response = await apiServices.userRegister(
          name, email, password, dob, gender, bio);

      // Check for registration success or error
      if (response.user != null) {
        _errorMessage = null;
      } else {
        _errorMessage = 'Registration failed. Please try again.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }


// for login
  Future<void> login(String email, String password) async {
    _setLoader(true);
    try {
      final AuthResponse response = await apiServices.userLogin(email, password);

      // Check for login success or error
      if (response.user != null) {
        _errorMessage = null;
      } else {
        _errorMessage = 'Login failed. Please check your credentials and try again.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
    } finally {
      _setLoader(false);
    }
  }

  void _setLoader(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

}
