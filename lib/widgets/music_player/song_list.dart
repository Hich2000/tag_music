import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {

  List<String> songs = [];

  @override
  void initState() {
    String filePath = "/storage/emulated/0/Music";
    Directory musicFolder = Directory(filePath);    

    for (var song in musicFolder.listSync()) {
      if (song is! File) {
        continue;
      }

      songs.add(song.path);
    }
  }


  @override
  Widget build(BuildContext context) {
    //get all music files on android
    return const Column(
      children: [
        
        ],
    );
  }
}
