import 'package:app_task/core/constants/route_name.main.dart';
import 'package:app_task/src/views/auth_views/login_view.dart';
import 'package:app_task/src/views/auth_views/signup_view.dart';
import 'package:app_task/src/views/dashboard_view/dashboard_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRouteName.dashboard,
      page: () => const DashBoardView(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRouteName.login,
      page: () => const LoginView(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRouteName.signup,
      page: () => const SignUpView(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
