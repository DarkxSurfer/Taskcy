import 'package:event_app/commons/custom_modal_sheet.dart';
import 'package:event_app/view/Project%20Screen/project_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../view/Chat/chat_screen.dart';
import '../view/HomeScreen/home_screen.dart';
import '../view/ProfileScreen/profile_screen.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _currentPageIndex = 0;

  final _screens = [
    const HomeScreen(),
    const ProjectScreen(),
    const Placeholder(),
    ChatScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _screens[_currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        child: NavigationBar(
          selectedIndex: _currentPageIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (index) =>
              _onDestinationSelected(context, index),
          destinations: [
            ///Home icon
            NavigationDestination(
                icon: Icon(Iconsax.home,
                    size: 28, color: theme.primaryColor.withOpacity(0.5)),
                selectedIcon: Icon(
                  Iconsax.home_15,
                  color: theme.iconTheme.color,
                  size: 28,
                ),
                label: ''),

            ///Folder icon
            NavigationDestination(
                icon: Icon(Iconsax.folder_minus,
                    color: theme.primaryColor.withOpacity(0.5)),
                selectedIcon: Icon(
                  Iconsax.folder_25,
                  color: theme.iconTheme.color,
                ),
                label: ''),

            ///Add icon
            NavigationDestination(
                icon: CircleAvatar(
                    radius: 28,
                    backgroundColor: theme.iconTheme.color,
                    child:
                        const Icon(Icons.add, size: 30, color: Colors.white)),
                selectedIcon: CircleAvatar(
                    radius: 28,
                    backgroundColor: theme.iconTheme.color,
                    child:
                        const Icon(Icons.add, size: 30, color: Colors.white)),
                label: ''),

            /// Message icon
            NavigationDestination(
                icon: Icon(Iconsax.message,
                    color: theme.primaryColor.withOpacity(0.5)),
                selectedIcon: Icon(
                  Iconsax.message5,
                  color: theme.iconTheme.color,
                ),
                label: ''),

            ///Profile icon
            NavigationDestination(
                icon: Icon(Icons.person_outline,
                    size: 28, color: theme.primaryColor.withOpacity(0.5)),
                selectedIcon: Icon(
                  Icons.person,
                  color: theme.iconTheme.color,
                  size: 28,
                ),
                label: ''),
          ],
        ),
      ),
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    if (index == 2) {
      // Show modal sheet if the middle icon (addIcon) is selected
      showModalBottomSheet(
        context: context,
        builder: (context) =>
            const CustomModalSheet(), // Your custom modal sheet
      );
    } else {
      setState(() {
        _currentPageIndex = index;
      });
    }
  }
}
