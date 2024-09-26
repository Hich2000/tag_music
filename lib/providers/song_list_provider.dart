
import 'dart:io';

import 'package:path/path.dart';

class SongListProvider {
  String filePath = "/storage/emulated/0/Music";
  List<String> songs = [];

  SongListProvider() {
    Directory musicFolder = Directory(filePath);

    for (var song in musicFolder.listSync()) {
      if (song is! File) {
        continue;
      }

      songs.add(song.path);
    }
  }
}