import 'package:edocman_demo/app/modules/home/binding.dart';
import 'package:edocman_demo/app/modules/home/page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding()
    )
  ];
}
