import 'package:app_task/core/constants/route_name.main.dart';
import 'package:app_task/core/helper/db/db_helper.dart';
import 'package:app_task/core/services/notification.dart';
import 'package:app_task/core/services/router.main.dart';
import 'package:app_task/core/services/theme_services.dart';
import 'package:app_task/core/theme/theme.dart';
import 'package:app_task/src/controller/services/injection_container_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DBHelper.initDb();
  await NotificationService.init();
  await GetStorage.init();
  InjectionContainerMain().dependencies();
  tz.initializeTimeZones();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      initialRoute: AppRouteName.login,
      getPages: AppPages.routes,
    );
  }
}
