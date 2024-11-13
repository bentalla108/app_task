import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

/// Service de gestion du thème (clair/sombre) de l'application.
/// Utilise GetStorage pour sauvegarder la préférence de thème localement.

class ThemeService {
  final _box =
      GetStorage(); // Instance de GetStorage pour lire/écrire les données localement.
  final _key =
      'isDarkMode'; // Clé utilisée pour stocker la préférence de thème.

  /// Récupère l'information sur le thème (clair/sombre) depuis le stockage local.
  /// Retourne ThemeMode.dark si le mode sombre est activé, sinon ThemeMode.light.
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Charge l'information "isDarkMode" depuis le stockage local.
  /// Si aucune valeur n'est trouvée, retourne "false" (thème par défaut : clair).
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  /// Enregistre la préférence "isDarkMode" dans le stockage local.
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Bascule le thème entre clair et sombre, puis enregistre la préférence mise à jour.
  void switchTheme() {
    // Change le mode de thème en utilisant Get, basculant entre clair et sombre.
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);

    // Sauvegarde la nouvelle préférence de thème dans le stockage local.
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
