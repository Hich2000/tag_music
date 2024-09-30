import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tag_music/providers/audio_player_provider.dart';
import 'package:tag_music/providers/song_list_provider.dart';
import 'package:tag_music/widgets/app.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void handlePermissions() async {
    final audioPermissionStatus = await Permission.audio.status;
    if (!audioPermissionStatus.isGranted) {
      await Permission.audio.request();
    }
  }

  @override
  void initState() {
    super.initState();
    handlePermissions();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SongListProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AudioPlayerProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: const App(),
      ),
    );
  }
}
