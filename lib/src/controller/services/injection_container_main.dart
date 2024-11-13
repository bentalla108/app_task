import 'package:app_task/src/controller/auth_controller.dart';
import 'package:app_task/src/controller/save_task_remote_controller.dart';
import 'package:app_task/src/controller/services/api_auth_services.dart';
import 'package:app_task/src/controller/services/remote_api.dart';
import 'package:get/get.dart';

class InjectionContainerMain implements Bindings {
  @override
  Future<void> dependencies() async {
    await _initAuth();
  }

  Future<void> _initAuth() async {
    Get.put<AuthController>(
        AuthController(Get.put<ApiAuthServiceImpl>(ApiAuthServiceImpl())),
        permanent: true);
    Get.put<SaveTaskRemoteController>(
        SaveTaskRemoteController(
            Get.put<ApiTaskServices>(RemoteDatasource(token: "token"))),
        permanent: true);
  }
}
