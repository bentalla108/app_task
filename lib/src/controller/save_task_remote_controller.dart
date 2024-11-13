import 'package:app_task/src/controller/services/remote_api.dart';
import 'package:app_task/src/controller/task_controller.dart';
import 'package:app_task/src/models/task.dart';
import 'package:get/get.dart';

class SaveTaskRemoteController extends GetxController {
  final ApiTaskServices apiTaskServices;

  // Liste des tâches sauvegardées
  var tasks = <TaskModel>[].obs;

  // Variable pour l'état de chargement
  var isLoading = false.obs;

  SaveTaskRemoteController(this.apiTaskServices);

  // Sauvegarder une tâche via l'API
  Future<void> saveTask() async {
    final TaskController taskController = Get.find<TaskController>();
    try {
      isLoading(true); // Indiquer que l'on est en train de charger
      await apiTaskServices
          .saveTask(taskController.taskList); // Appel au service API
      tasks.assignAll(
          taskController.taskList); // Ajouter lestâches à la liste des tâches
      Get.snackbar('Reussie', 'Taches sauvegardées');
      isLoading(false); // Fin de l'opération
    } catch (e) {
      isLoading(false); // Fin de l'opération en cas d'erreur
      if (e is Exception) {
        ///Pour  des raison de simulation et on garde l'option reussi
        ///Une fois l'API branché on remet l'implementation opour le cas ou la requette echoue

        Get.snackbar('Reussie', 'Taches sauvegardées');
        // Afficher un message d'erreur ou autre gestion
        // Get.snackbar('Erreur', 'Impossible de sauvegarder la tâche');
      }
    }
  }

  // Charger les tâches via l'API
  Future<void> loadTasks() async {
    try {
      isLoading(true);
      final loadedTasks = await apiTaskServices
          .loadTasks(); // Récupérer les tâches depuis l'API
      tasks.value =
          loadedTasks.map((taskMap) => TaskModel.fromJson(taskMap)).toList();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Erreur', 'Impossible de charger les tâches');
    }
  }

  // Modifier une tâche existante via l'API
  Future<void> editTask(int id, Map<String, dynamic> updatedTask) async {
    try {
      isLoading(true);
      await apiTaskServices.editTask(
          id, updatedTask); // Appel à l'API pour éditer la tâche
      loadTasks(); // Recharger la liste des tâches après modification
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Erreur', 'Impossible de modifier la tâche');
    }
  }

  // Supprimer une tâche via l'API
  Future<void> deleteTask(int id) async {
    try {
      isLoading(true);
      await apiTaskServices
          .deleteTask(id); // Appel à l'API pour supprimer la tâche
      tasks.removeWhere(
          (task) => task.id == id); // Supprimer la tâche de la liste locale
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Erreur', 'Impossible de supprimer la tâche');
    }
  }
}
