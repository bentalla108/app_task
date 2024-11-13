import 'dart:developer';

import 'package:app_task/core/constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart';

/// Interface de base pour les services d'inscription, de connexion et de déconnexion.
/// Elle permet de séparer la logique de l'authentification du contrôleur,
/// ce qui rend le code plus flexible et maintenable.
abstract class ApiAuthServices {
  Future<void> signUp(Map<String, dynamic> user);
  Future<void> signIn(Map<String, dynamic> credentials);
  Future<void> logOut();
}

/// ====================================================================///

class ApiAuthServiceImpl extends ApiAuthServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: API_BASE,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // Utilisation de GetStorage pour stocker localement des données d'authentification
  final GetStorage _storage = GetStorage();
  static const _tokenKey = 'auth_token'; // Clé pour stocker le token

  /// Méthode d'inscription [signUp] via l'API.
  /// Cette méthode envoie une requête POST avec les informations de l'utilisateur.
  /// En cas de succès, elle retourne un message de confirmation.
  /// En cas d'échec, elle génère une exception avec le message d'erreur.
  @override
  Future<void> signUp(Map<String, dynamic> user) async {
    try {
      log(' -----> ${user.runtimeType}');
      final response = await _dio.post(SIGNUP, data: user);

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('Inscription réussie.');
        }
      } else {
        throw Exception(
            'Erreur lors de l\'inscription : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      if (kDebugMode) {
        print('Erreur d\'inscription : ${e.message}');
      }
      throw Exception('Erreur d\'inscription : ${e.response?.data}');
    }
  }

  /// Méthode de connexion [signIn] via l'API.
  /// Si la connexion est réussie, le token reçu est stocké dans GetStorage.
  /// En cas d'erreur, elle génère une exception avec le message d'erreur.
  @override
  Future<void> signIn(Map<String, dynamic> credentials) async {
    try {
      final response = await _dio.post(SIGNIN, data: credentials);

      if (response.statusCode == 200) {
        final token = response.data['token'];
        if (kDebugMode) {
          print('Connexion réussie, token reçu : $token');
        }

        // Sauvegarde du token dans GetStorage pour une utilisation ultérieure
        await _storage.write(_tokenKey, token);
      } else {
        throw Exception(
            'Erreur lors de la connexion : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Erreur de connexion : ${e.message}');
      }
      throw Exception('Erreur de connexion : ${e.response?.data}');
    }
  }

  /// Méthode de déconnexion [logOut].
  /// Elle supprime le token stocké dans GetStorage pour invalider la session.
  /// En cas d'erreur, elle génère une exception avec le message d'erreur.
  @override
  Future<void> logOut() async {
    try {
      await _storage.remove(_tokenKey);
      if (kDebugMode) {
        print('Déconnexion réussie.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erreur lors de la déconnexion : $e');
      }
      throw Exception('Erreur de déconnexion');
    }
  }

  /// Récupère le token depuis GetStorage pour authentifier les requêtes.
  /// Retourne null si le token n'existe pas.
  Future<String?> getToken() async {
    return _storage.read(_tokenKey);
  }
}
