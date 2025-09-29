import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const AppBottomNavBar({
    required this.currentIndex,
    required this.onTabTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The items follow the structure on pages 9, 10, 11, 12, 13 [cite: 155-157, 170, 183, 193-197, 210-212]
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      selectedItemColor: Colors.blue[900], // Primary color
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed, // To show all labels
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home', // Page 9 [cite: 155]
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Ranking', // Page 9 [cite: 156]
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Store', // Page 9 (Loja de recompensas - RF08) [cite: 157, 83]
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
          label: 'Inovation', // Page 9 [cite: 157]
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile', // Page 9 [cite: 157]
        ),
      ],
    );
  }
}