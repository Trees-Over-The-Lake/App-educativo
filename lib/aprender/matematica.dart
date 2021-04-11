import 'package:educativo/aprender/youtube.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Matematica extends StatefulWidget {
  static const routeName = 'Matematica';

  @override
  _MatematicaState createState() => _MatematicaState();
}

class _MatematicaState extends State<Matematica> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'yzYMuPqYoPM',
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
        title: Text('Matemática'),
        centerTitle: true,
      ),
      body: buildAulas(_controller, false),
    );
  }
}
