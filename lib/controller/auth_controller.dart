import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;

  Future<void> register(String username, String email, String password) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user_$username')) {
      isLoading.value = false;
      Get.snackbar(
        'Gagal',
        'Username sudah digunakan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
      );
      return;
    }
    await prefs.setString('user_$username', password);
    await prefs.setString('email_$username', email);
    isLoading.value = false;
    Get.snackbar(
      'Berhasil',
      'Akun dibuat, silakan login',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF43A047),
      colorText: const Color(0xFFFFFFFF),
    );
    await Future.delayed(const Duration(milliseconds: 800));
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('user_$username');
    if (stored == null) {
      isLoading.value = false;
      Get.snackbar(
        'Gagal',
        'Username tidak ditemukan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
      );
      return;
    }
    if (stored != password) {
      isLoading.value = false;
      Get.snackbar(
        'Gagal',
        'Password salah',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
      );
      return;
    }
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('username', username);
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
    Get.offAllNamed(AppRoutes.login);
  }

  static Future<String> getSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }
}
