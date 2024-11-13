import 'package:app_task/core/theme/theme.dart';
import 'package:app_task/src/views/tasks_view/calendar_views.dart';
import 'package:app_task/src/views/profile_view/profile_views.dart';
import 'package:flutter/material.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  static const routeName = '/dashboard';

  @override
  _DashBoardViewState createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const TaskView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody:
          true, // Permet au fond de navigation de flotter au-dessus du fond de l'écran.
      body: _pages[_selectedIndex], // Affiche la page sélectionnée
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20.0)
            .copyWith(bottom: 5, top: 5), // Espacement pour l'effet flottant
        decoration: BoxDecoration(
          color: Colors.white, // Couleur de fond du menu de navigation
          borderRadius: BorderRadius.circular(
              30.0), // Coins arrondis pour l'effet de capsule
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            enableFeedback: false,

            backgroundColor: Colors
                .transparent, // Transparent pour voir la couleur du Container
            elevation: 0, // Pas d'ombre supplémentaire
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Calendrier',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: bluishClr, // Couleur de l'icône sélectionnée
            unselectedItemColor:
                Colors.grey, // Couleur des icônes non sélectionnées
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
