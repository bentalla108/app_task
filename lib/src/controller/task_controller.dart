import 'package:app_task/core/helper/db/db_helper.dart';
import 'package:app_task/core/helper/utils.dart';
import 'package:app_task/core/services/notification.dart';
import 'package:app_task/src/models/task.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

// TaskController: Contrôleur principal pour gérer les tâches.
// Ce contrôleur utilise GetX pour surveiller les changements de données dans la liste des tâches,
// ce qui permet de mettre à jour automatiquement l'interface utilisateur lorsque des données sont modifiées.
class TaskController extends GetxController {
  // Méthode appelée lorsque le contrôleur est prêt.
  // Elle initialise les tâches en appelant getTasks pour récupérer les données existantes depuis la base de données.
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  // Liste réactive des tâches, permettant la gestion dynamique et en temps réel de la liste de tâches dans l'UI.
  final RxList<TaskModel> taskList = List<TaskModel>.empty().obs;

  // Méthode asynchrone pour ajouter une tâche dans la base de données.
  // Si un rappel est défini pour la tâche, une notification est programmée.
  Future<void> addTask({required TaskModel task}) async {
    await DBHelper.insert(task);

    // Si un rappel (remind) est défini, programme une notification pour la tâche.
    if (task.remind != null && task.remind! > 0) {
      // Récupère l'heure de début de la tâche à partir de la chaîne de caractères (ex. "08:30").

      final startTime = TimeOfDay(
        hour: int.parse(convertTimeFormat(task.startTime).split(":")[0]),
        minute: int.parse(convertTimeFormat(task.startTime).split(":")[1]),
      );

      // Calcule l'heure prévue pour la notification en fonction de l'heure de début et du rappel.
      final scheduledTime = DateTime(
        task.date.year,
        task.date.month,
        task.date.day,
        startTime.hour,
        startTime.minute,
      ).subtract(Duration(minutes: task.remind!));

      // Planifie la notification en utilisant le service de notification.
      await NotificationService.scheduleNotification(
        task.hashCode, // ID unique pour la notification de la tâche
        task.title,
        task.description,
        scheduledTime,
      );
    }
  }

  // Récupère toutes les tâches depuis la base de données et met à jour la liste réactive.
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => TaskModel.fromJson(data)).toList());
    print(taskList.length); // Debug: affiche le nombre de tâches récupérées.
  }

  // Récupère les tâches en fonction d'une date précise.
  // Utilise DateUtils pour comparer les dates et filtrer uniquement les tâches du jour demandé.
  Future<void> getTaskByDate(DateTime date) async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();

    taskList.assignAll(
      tasks
          .map((data) => TaskModel.fromJson(data))
          .where((element) => DateUtils.isSameDay(element.date, date))
          .toList(),
    );
  }

  // Supprime une tâche de la base de données et rafraîchit la liste des tâches affichées.
  void deleteTask(TaskModel task) async {
    await DBHelper.delete(task);
    getTasks(); // Actualise la liste après suppression.
  }

  // Marque une tâche comme complétée dans la base de données en mettant à jour son état.
  // Ensuite, recharge les tâches pour refléter le changement.
  void markTaskCompleted(int? id) async {
    await DBHelper.update(id);
    getTasks(); // Rafraîchit la liste après la mise à jour.
  }
}
