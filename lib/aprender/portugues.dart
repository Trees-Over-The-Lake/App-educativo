import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'youtube.dart';

class Portugues extends StatefulWidget {
  static const routeName = 'Portugues';

  @override
  _PortuguesState createState() => _PortuguesState();
}

class _PortuguesState extends State<Portugues> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'WG48Wk0Fu9Q',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alfabeto'),
        centerTitle: true,
      ),
      body: buildAulas(_controller, true),
    );
  }
}
