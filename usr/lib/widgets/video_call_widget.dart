import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCallWidget extends StatefulWidget {
  const VideoCallWidget({super.key});

  @override
  State<VideoCallWidget> createState() => _VideoCallWidgetState();
}

class _VideoCallWidgetState extends State<VideoCallWidget> {
  late VideoPlayerController _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // Use network video as alternative, or show placeholder if asset not available
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      // Alternative: Use a placeholder image or text instead of video
      // For now, try to load a sample video from network if asset doesn't exist
      _controller = VideoPlayerController.networkUrl(
        Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
      )..initialize().then((_) {
        if (mounted) setState(() {});
        _controller.play();
      }).catchError((error) {
        setState(() => _hasError = true);
      });
    } catch (e) {
      setState(() => _hasError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError || !_controller.value.isInitialized) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.video_call, size: 64, color: Colors.white),
              SizedBox(height: 16),
              Text(
                'Video Call in Progress',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                'Healthcare professional will join shortly',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
