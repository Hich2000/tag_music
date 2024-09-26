import 'package:flutter/material.dart';

import 'package:tag_music/widgets/menu.dart';
import 'package:tag_music/widgets/music_player/song_list.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedPageIndex = 0;
  void _onDestinationSelected(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  //only need to add a key value pair here to create a menu option and page
  final Map<NavigationDestination, Widget> _navigation = {
    const NavigationDestination(
      icon: Icon(Icons.music_note),
      label: 'Songs',
    ): const SongList(),
    const NavigationDestination(
      icon: Icon(Icons.business),
      label: 'Business',
    ): const Text(
      'Index 1: Business',
      style: optionStyle,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Sample'),
      ),
      body: Center(
        child: _navigation.values.elementAt(_selectedPageIndex),
      ),
      bottomNavigationBar: Menu(
        onDestinationSelected: _onDestinationSelected,
        navigationList: _navigation.keys.toList(),
        selectedIndex: _selectedPageIndex,
      ),
    );
  }
}
