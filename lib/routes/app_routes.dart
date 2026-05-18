import 'package:get/get.dart';
import '../view/login_page.dart';
import '../view/home_page.dart';
import '../view/detail_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String detail = '/detail';

  static final List<GetPage> pages = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: detail, page: () => const DetailPage()),
  ];
}
