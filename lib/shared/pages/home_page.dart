import 'package:flutter/material.dart';
import 'package:todo_list_project/features/task/pages/tasks_page.dart';

import '../../features/auth/pages/profile_page.dart';
import '../themes/navigation_bar_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
  }

  setCurrentPage(page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: setCurrentPage,
        children: const [
          TaskPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: GetNavigationBarTheme(),
        child: NavigationBar(
          selectedIndex: currentPage,
          onDestinationSelected: (page) {
            pageController.animateToPage(page, duration: const Duration(milliseconds: 400), curve: Curves.ease);
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.task_outlined),
                selectedIcon: Icon(Icons.task),
                label: 'tasks'),
            NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'profile'),
          ],
        ),
      ),
    );
  }
}
