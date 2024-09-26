import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  List<String> songs = [];

  @override
  void initState() {
    super.initState();

    String filePath = "/storage/emulated/0/Music";
    Directory musicFolder = Directory(filePath);

    for (var song in musicFolder.listSync()) {
      if (song is! File) {
        continue;
      }

      songs.add(basename(song.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    //get all music files on android
    return ListView.builder(
      itemCount: songs.length,
      prototypeItem: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.album),
              title: Text(
                songs.first,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.album),
                title: Text(
                  songs[index],
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
