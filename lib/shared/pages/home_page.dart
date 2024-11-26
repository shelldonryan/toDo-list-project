import 'package:flutter/material.dart';
import 'package:todo_list_project/features/task/pages/filter_all_task_page.dart';
import 'package:todo_list_project/features/task/pages/tasks_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../features/auth/pages/profile_page.dart';
import '../themes/navigation_bar_theme.dart';

class HomePage extends StatefulWidget {
  final bool isDeveloper;

  const HomePage({super.key, required this.isDeveloper});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Widget> _getPages() {
    List<Widget> pages = [const TaskPage()];
    if (widget.isDeveloper) {
      pages.add(const FilterAllTaskPage());
    }

    pages.add(const ProfilePage());
    return pages;
  }

  List<NavigationDestination> _getNavigationDestinations() {
    List<NavigationDestination> destinations = [
      NavigationDestination(
          icon: const Icon(Icons.task_outlined),
          selectedIcon: const Icon(Icons.task),
          label: AppLocalizations.of(context)!.taskNavigationBar),
      NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: AppLocalizations.of(context)!.profileNavigationBar),
    ];

    if (widget.isDeveloper) {
      destinations.insert(
        1,
        NavigationDestination(
          icon: const Icon(Icons.groups_2_outlined),
          selectedIcon: const Icon(Icons.groups_2),
          label: AppLocalizations.of(context)!.allTaskNavigationBar,
        ),
      );
    }

    return destinations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: _getPages(),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: GetNavigationBarTheme(),
        child: NavigationBar(
          selectedIndex: currentPage,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (page) {
            setState(() {
              currentPage = page;
            });
          },
          destinations: _getNavigationDestinations(),
        ),
      ),
    );
  }
}
