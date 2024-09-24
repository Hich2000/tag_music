import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu(
      {super.key,
      required this.onDestinationSelected,
      required this.navigationList,
      required this.selectedIndex});

  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> navigationList;
  final int selectedIndex;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: widget.onDestinationSelected,
      destinations: widget.navigationList,
    );
  }
}
