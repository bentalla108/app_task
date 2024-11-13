import 'package:app_task/common/widgets/button.dart';
import 'package:app_task/core/constants/route_name.main.dart';
import 'package:app_task/src/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Classe représentant la vue d'inscription utilisateur
/// Utilise le contrôleur AuthController pour gérer la logique d'inscription
class SignUpView extends GetView<AuthController> {
  const SignUpView({super.key});

  static const String routeName =
      '/signup'; // Définition de la route pour la vue d'inscription

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0), // Espacement autour du formulaire
        child: Form(
          key: controller.signUpFormKey, // Clé pour valider le formulaire
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centrage des éléments dans la vue
            children: [
              const Text(
                'Inscription.', // Titre de la vue d'inscription
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height: 20), // Espacement entre le titre et les champs
              // Champ pour le nom
              TextFormField(
                controller: controller
                    .signUpNameController, // Contrôleur de texte pour le nom
                decoration: const InputDecoration(
                  hintText: 'Nom', // Placeholder pour le champ du nom
                ),
                validator: (value) {
                  // Validation du champ nom
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom'; // Message d'erreur si le champ est vide
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Champ pour l'email
              TextFormField(
                controller: controller
                    .signUpEmailController, // Contrôleur de texte pour l'email
                decoration: const InputDecoration(
                  hintText: 'Email', // Placeholder pour le champ email
                ),
                validator: (value) {
                  // Validation de l'email
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un email'; // Message d'erreur si le champ est vide
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Champ pour le mot de passe
              TextFormField(
                controller: controller
                    .signUpPasswordController, // Contrôleur de texte pour le mot de passe
                decoration: const InputDecoration(
                  hintText:
                      'Mot de passe', // Placeholder pour le champ mot de passe
                ),
                obscureText: true, // Masque le mot de passe
                validator: (value) {
                  // Validation du mot de passe
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe'; // Message d'erreur si le champ est vide
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Affiche un indicateur de chargement ou le bouton d'inscription
              Obx(() {
                return controller.isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors
                            .white) // Indicateur de chargement pendant l'inscription
                    : AppButton(
                        onTap: controller.isLoading.value
                            ? null // Désactive le bouton pendant le chargement
                            : () => controller
                                .signUp(), // Exécute l'inscription lorsque le bouton est pressé
                        label: 'Inscription', // Libellé du bouton
                      );
              }),
              const SizedBox(height: 20),
              // Lien pour aller à la vue de connexion si l'utilisateur a déjà un compte
              GestureDetector(
                onTap: () => Get.offNamed(
                    AppRouteName.login), // Navigation vers la page de connexion
                child: RichText(
                  text: TextSpan(
                    text:
                        'Déjà inscrit? ', // Texte invitant l'utilisateur à se connecter
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Connexion', // Texte souligné pour la connexion
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
