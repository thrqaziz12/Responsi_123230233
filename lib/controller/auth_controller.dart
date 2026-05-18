import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var loggedInUsername = ''.obs;
  var isLoading = false.obs;

  static const String _keyUsername = 'username';
  static const String _keyLoggedIn = 'is_logged_in';

  final Map<String, String> _validUsers = {
    'thoriq': '233',
  };

  @override
  void onInit() {
    super.onInit();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool(_keyLoggedIn) ?? false;
    loggedInUsername.value = prefs.getString(_keyUsername) ?? '';
  }

  Future<bool> login(String username, String password) async {
    isLoading.value = true;
    final expectedPassword = _validUsers[username.toLowerCase()];
    if (expectedPassword != null && password == expectedPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyLoggedIn, true);
      await prefs.setString(_keyUsername, username);
      isLoggedIn.value = true;
      loggedInUsername.value = username;
      isLoading.value = false;
      return true;
    }
    isLoading.value = false;
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLoggedIn);
    await prefs.remove(_keyUsername);
    isLoggedIn.value = false;
    loggedInUsername.value = '';
  }
}
