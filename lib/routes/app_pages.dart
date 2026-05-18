import 'package:get/get.dart';
import '../view/pages/login_page.dart';
import '../view/pages/home_page.dart';
import '../view/pages/detail_page.dart';
import '../controller/auth_controller.dart';
import '../controller/list_controller.dart';
import '../controller/detail_controller.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AuthController())),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ListController())),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => DetailController())),
    ),
  ];
}
