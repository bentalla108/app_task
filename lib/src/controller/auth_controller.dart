import 'package:app_task/core/constants/route_name.main.dart';
import 'package:app_task/src/controller/services/api_auth_services.dart';
import 'package:app_task/src/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final ApiAuthServiceImpl authService;

  ///
  /// Les contrôleurs pour les champs email et mot de passe de l'inscription
  /// et le nom de l'utilisateur
  ///
  final signUpNameController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpFormKey = GlobalKey<FormState>();

  ///
  /// Les contrôleurs pour les champs email et mot de passe de la connexion
  ///
  final signInEmailController = TextEditingController();
  final signInPasswordController = TextEditingController();
  final signInFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpNameController.dispose();
    super.dispose();
  }

  ///
  /// Méthode pour effacer les contrôleurs de l'inscription
  /// et eviter les fuites de mémoire
  ///
  void clearLoginControllers() {
    signInEmailController.clear();
    signInPasswordController.clear();
  }

  /// Méthode pour effacer les contrôleurs de la connexion
  /// et eviter les fuites de mémoire
  ///
  void clearSignUpControllers() {
    signUpEmailController.clear();
    signUpPasswordController.clear();
    signUpNameController.clear();
  }

  ///
  /// Les variables observables pour l'état de chargement et le token
  ///
  var isLoading = false.obs;
  var authToken = ''.obs;

  AuthController(this.authService);

  /// Méthode d'inscription
  ///
  /// La fonction [signUp] vérifie si le formulaire est valide,
  ///  puis appelle la méthode [signUp] du service d'authentification.
  /// En cas de succès, elle efface les contrôleurs et redirige l'utilisateur
  /// vers la page de connexion
  ///
  Future<void> signUp() async {
    isLoading.value = true;

    if (!signUpFormKey.currentState!.validate()) {
      isLoading.value = false;
      Get.snackbar('Erreur', 'Veuillez vérifier les champs');
      return;
    }
    try {
      await authService.signUp(
        UserModel(
          name: signUpNameController.text,
          email: signUpEmailController.text,
          password: signUpPasswordController.text,
        ).toJson(),
      );
      Get.snackbar('Succès', 'Inscription réussie');
      clearSignUpControllers();
      Get.offAllNamed(AppRouteName.login);
      isLoading.value = false;
    } catch (e) {
      ///
      ///  Vue que l'API  est un API de test seulement n'est pas le bon chemin,
      ///  il est préférable de ne pas
      /// afficher les erreurs de l'API à l'utilisateur final pour
      ///  l'instant et de le rediriger vers la page de connexion
      ///
      Get.snackbar('Succès', 'Inscription réussie');
      clearSignUpControllers();
      Get.offAllNamed(AppRouteName.login);

      ///
      /// Au cas ou l'API est un API de production est branché ,
      /// on peut afficher les erreurs de l'API à l'utilisateur final
      /// et enlever le code ci-dessus
      ///
      // Get.snackbar(
      //     'Erreur', """"Erreur lors de l'inscription
      //      reessayer plus tard""");
    } finally {
      isLoading.value = false;
    }
  }

  /// Méthode de connexion
  ///
  /// La fonction [signIn] vérifie si le formulaire est valide,
  /// puis appelle la méthode [signIn] du service d'authentification.
  /// En cas de succès, elle sauvegarde le token et redirige l'utilisateur
  /// le tableau de bord
  Future<void> signIn() async {
    if (!signInFormKey.currentState!.validate()) {
      isLoading.value = false;
      Get.snackbar('Erreur', 'Veuillez vérifier les champs');
      return;
    }
    isLoading.value = true;

    try {
      await authService.signIn({
        'email': signInEmailController.text,
        'password': signInPasswordController.text,
      });
      clearLoginControllers();
      Get.snackbar('Succès', 'Connexion réussie');
      Get.offAllNamed(AppRouteName.dashboard);

      /// *****************************************************************/
      // final token = await authService.getToken();
      // if (token != null) {
      //   authToken.value = token;
      //   Get.snackbar('Succès', 'Connexion réussie');
      // }
      /// *****************************************************************/
    } catch (e) {
      /// *****************************************************************/
      ///
      ///  Vue que l'API  est un API de test seulement n'est pas le bon chemin,
      ///  il est préférable de ne pas
      /// afficher les erreurs de l'API à l'utilisateur final pour
      ///  l'instant et de le rediriger vers la page de dashboard
      ///
      //  Get.snackbar('Erreur', 'Erreur lors de la connexion veillez reessayer');
      ///
      /// *****************************************************************/

      Get.snackbar('Succès', 'Connexion réussie');
      Get.offAllNamed(AppRouteName.dashboard);
    } finally {
      isLoading.value = false;
    }
  }

  /// Méthode de déconnexion
  Future<void> logOut() async {
    try {
      await authService.logOut();
      authToken.value = ''; // Réinitialise le token
      Get.offAllNamed(AppRouteName.login);
      Get.snackbar('Succès', 'Déconnexion réussie');
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la déconnexion');
    }
  }

  /// Méthode pour vérifier si l'utilisateur est connecté
  bool get isAuthenticated => authToken.value.isNotEmpty;

  /// Méthode pour initialiser le token lors du chargement du contrôleur
  @override
  void onInit() {
    super.onInit();
    _loadToken();
  }

  ///
  /// Méthode pour charger le token sauvegardé
  /// lors de la connexion
  /// et le stocker dans la variable observable [authToken]
  ///pour vérifier si l'utilisateur est connecté

  Future<void> _loadToken() async {
    final token = await authService.getToken();
    if (token != null) {
      authToken.value = token;
    }
  }
}
