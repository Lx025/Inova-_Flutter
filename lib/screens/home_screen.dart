import 'package:eurofarma_project/screens/innovation_submission_screen.dart';
import 'package:eurofarma_project/screens/profile_screen.dart';
import 'package:eurofarma_project/screens/ranking_screen.dart';
import 'package:eurofarma_project/utils/mock_data.dart';
import 'package:eurofarma_project/widgets/app_bottom_nav_bar.dart';
import 'package:eurofarma_project/widgets/idea_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Current screen index in the bottom nav bar

  final List<Widget> _screens = [
    // This screen itself (Feed/Home)
    _FeedScreenContent(), 
    const RankingScreen(), // Ranking screen
    const Center(child: Text('Store Screen (Loja de Recompensas RF08)')),
    const InnovationSubmissionScreen(), // Innovation submission screen
    const ProfileScreen(), // Profile screen
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inovações', style: TextStyle(color: Colors.white)), // Based on Page 9 [cite: 141]
        backgroundColor: Colors.blue[900],
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.search, color: Colors.white), // Search icon
          ),
        ],
      ),
      // Body changes according to the selected tab
      body: _screens[_currentIndex],
      // Bottom navigation bar component (RF03, RF07, RF08, RF09)
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}

// Separate widget for the feed content
class _FeedScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 10),
      itemCount: mockIdeas.length,
      separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
      itemBuilder: (context, index) {
        return IdeaCard(idea: mockIdeas[index]);
      },
    );
  }
}
