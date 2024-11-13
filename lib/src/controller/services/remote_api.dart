import 'package:app_task/core/constants/api_constant.dart';
import 'package:app_task/src/models/task.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

/// Interface pour les services de sauvegarde des tâches API.
///
/// Cette classe abstraite définit les méthodes principales
/// pour sauvegarder et charger les tâches via une API.
/// Elle sert de contrat que les implémentations concrètes doivent respecter
/// pour sauvegarder, charger, éditer et supprimer les tâches.
abstract class ApiTaskServices {
  Future<void> saveTask(List<TaskModel> task);
  Future<List<Map<String, dynamic>>> loadTasks();
  Future<void> editTask(int id, Map<String, dynamic> updatedTask);
  Future<void> deleteTask(int id);
}

/// Implémentation concrète des services de sauvegarde API pour les tâches.
class RemoteDatasource extends ApiTaskServices {
  final String? token; // Token JWT pour l'authentification
  late Dio _dio;

  RemoteDatasource({required this.token}) {
    // Configuration de Dio avec les options de base
    _dio = Dio(
      BaseOptions(
        baseUrl: API_BASE,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  /// Méthode pour sauvegarder une tâche via l'API (POST) avec Dio.
  @override
  Future<void> saveTask(List<TaskModel> task) async {
    try {
      // Envoi de la requête POST
      final response = await _dio.post(
        TASK,
        data: task,
      );

      // Vérification du statut de la réponse
      if (response.statusCode == 201) {
        // 201 Created
        if (kDebugMode) {
          print('Tâche sauvegardée avec succès.');
        }
      } else {
        throw Exception(
            'Erreur lors de la sauvegarde de la tâche: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Gestion des erreurs Dio
      if (e.response != null) {
        if (kDebugMode) {
          print(
              'Erreur API: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        }
        throw Exception(
            'Erreur lors de la sauvegarde de la tâche: ${e.response?.data}');
      } else {
        if (kDebugMode) {
          print('Erreur de réseau ou autre erreur: ${e.message}');
        }
        throw Exception('Erreur réseau: ${e.message}');
      }
    }
  }

  @override
  Future<List<Map<String, dynamic>>> loadTasks() {
    // TODO: Implémenter la logique pour charger les tâches via l'API
    throw UnimplementedError();
  }

  @override
  Future<void> editTask(int id, Map<String, dynamic> updatedTask) {
    // TODO: Implémenter la logique pour modifier une tâche via l'API
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(int id) {
    // TODO: Implémenter la logique pour supprimer une tâche via l'API
    throw UnimplementedError();
  }
}
