import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:tag_music/providers/audio_player_provider.dart';
import 'package:tag_music/providers/song_list_provider.dart';

class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    final List<String> songs = context.read<SongListProvider>().songs;
    void Function(String) playSong = context.read<AudioPlayerProvider>().playSong;

    //get all music files on android
    return ListView.builder(
      itemCount: songs.length,
      prototypeItem: InkWell(
        onTap: () {
          playSong(songs.first);
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.album),
                title: Text(
                  basename(songs.first),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              playSong(songs[index]);
            },
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.album),
                    title: Text(
                      basename(songs[index]),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
