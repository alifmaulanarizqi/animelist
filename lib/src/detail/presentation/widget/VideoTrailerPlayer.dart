import 'package:flutter/material.dart';
import 'package:fms/common_ui/utils/colors/common_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTrailerPlayer extends StatefulWidget {
  final String youtubeId;

  const VideoTrailerPlayer({
    super.key,
    required this.youtubeId,
  });

  @override
  _VideoTrailerPlayerState createState() => _VideoTrailerPlayerState();
}

class _VideoTrailerPlayerState extends State<VideoTrailerPlayer> {
  late YoutubePlayerController  _videoController;

  @override
  void initState() {
    super.initState();

    _initializeVideoUrl(videoId: widget.youtubeId);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _initializeVideoUrl({
    required String videoId
  }) {
    _videoController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YoutubePlayer(
        controller: _videoController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: CommonColors.orange00,
        progressColors: const ProgressBarColors(
          playedColor: CommonColors.orange00,
          handleColor: Colors.amberAccent,
        ),
      ),
    );
  }

}