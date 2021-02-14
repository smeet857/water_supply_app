import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VPlayer extends StatefulWidget {

  final String url;

  const VPlayer({Key key, this.url,}) : super(key: key);
  @override
  _VPlayerState createState() => _VPlayerState();
}

class _VPlayerState extends State<VPlayer> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void dispose() async {
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: chewieController);
  }

  Future<void> _initializeVideo()async{
    videoPlayerController = VideoPlayerController.network(widget.url.replaceAll("http", "https"));
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
      autoInitialize: true,
      showControls: true,
      allowFullScreen: true,
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
      aspectRatio: 16/9
    );
  }
}
