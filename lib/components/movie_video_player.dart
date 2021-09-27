import 'package:flutter/material.dart';
import 'package:totor/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieVideoPlayer extends StatelessWidget {
  const MovieVideoPlayer({Key? key, required this.v}) : super(key: key);

  final Video v;

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: v.key,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }
}
