import 'package:app_task/common/widgets/button.dart';
import 'package:app_task/core/constants/route_name.main.dart';
import 'package:app_task/src/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Classe représentant la vue de connexion utilisateur
/// Utilise le contrôleur AuthController pour gérer la logique de connexion
class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // AppBar standard
      body: Padding(
        padding: const EdgeInsets.all(15.0), // Espacement autour du formulaire
        child: Form(
          key: controller.signInFormKey, // Clé pour valider le formulaire
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centre les éléments dans la vue
            children: [
              const Text(
                'Sign In.', // Titre de la vue de connexion
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height: 30), // Espacement entre le titre et les champs
              TextFormField(
                validator: (value) {
                  // Validation de l'email
                  if (value != null && !GetUtils.isEmail(value)) {
                    return "Email is not valid";
                  } else {
                    return null;
                  }
                },
                controller: controller
                    .signInEmailController, // Contrôleur de texte pour l'email
                decoration: const InputDecoration(
                  hintText: 'Email', // Placeholder pour le champ email
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (value) {
                  // Validation du mot de passe
                  if (value != null && !GetUtils.isPassport(value)) {
                    return "Password is not valid";
                  } else {
                    return null;
                  }
                },
                controller: controller
                    .signInPasswordController, // Contrôleur de texte pour le mot de passe
                decoration: const InputDecoration(
                  hintText:
                      'Password', // Placeholder pour le champ mot de passe
                ),
                obscureText: true, // Masque le mot de passe
              ),
              const SizedBox(height: 20),
              AppButton(
                onTap: () {
                  // Action de connexion
                  controller.signIn();
                },
                label: 'SIGN IN', // Libellé du bouton de connexion
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Navigation vers la vue d'inscription
                  Get.toNamed(AppRouteName.signup);
                },
                child: RichText(
                  text: TextSpan(
                    text:
                        'Pas encore de compte ? ', // Texte invitant l'utilisateur à s'inscrire
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text:
                            'Inscrez-vous', // Texte souligné pour l'inscription
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
