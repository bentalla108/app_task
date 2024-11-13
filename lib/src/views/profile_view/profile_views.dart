// ignore_for_file: unused_import

import 'dart:developer';

import 'package:app_task/common/widgets/custom_widget.dart';
import 'package:app_task/src/controller/auth_controller.dart';
import 'package:app_task/src/controller/save_task_remote_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    String timeString = "08:30 PM";

    // Parse the time string to a DateTime object
    DateTime dateTime = DateFormat.Hm().parse(timeString);

    // Extract the hour, minute, and period (AM/PM)
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    int minute = dateTime.minute;
    String period = dateTime.hour >= 12 ? "PM" : "AM";

    // Handle cases where hour might be 0 (midnight) to display as 12
    hour = (hour == 0) ? 12 : hour;

    log("Hour: $hour, Minute: $minute, Period: $period");

    ///
    ///
    final AuthController authController = Get.find<AuthController>();
    final SaveTaskRemoteController saveTaskRemoteController =
        Get.find<SaveTaskRemoteController>();
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                      'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png'), // Image depuis l'URL
                  child: Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Nom d'utilisateur ou email
              Text(
                'Nom d\'utilisateur',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),

              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text("Modifier mon mot de passe"),
                onTap: () {
                  Navigator.pushNamed(context, '/change_password');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text("Paramètres de confidentialité"),
                onTap: () {
                  Navigator.pushNamed(context, '/privacy_settings');
                },
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.cloud_upload),
                title: const Text("Sauvegarder mes tâches"),
                onTap: () {
                  saveTaskRemoteController.saveTask();
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //       content: Text(
                  //           "Tâches synchronisées avec succès sur le cloud !")),
                  // );
                },
              ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Deconnexion"),
                onTap: () {
                  authController.logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
