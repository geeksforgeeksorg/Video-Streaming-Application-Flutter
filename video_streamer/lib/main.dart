import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player',
      home: VideoStreamer(),
    );
  }
}

class VideoStreamer extends StatefulWidget {
  const VideoStreamer({super.key});

  @override
  State<VideoStreamer> createState() => _VideoStreamerState();
}

class _VideoStreamerState extends State<VideoStreamer> {
  VideoPlayerController? _controller;
  String videoUrl =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1F1F1F),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          title: const Text(
            "Geeks For Geeks",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            _controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  )
                : const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Text(
                      "Something went wrong ",
                      style: TextStyle(color: Colors.red, fontSize: 28),
                    ),
                  ),
            VideoProgressIndicator(_controller!, allowScrubbing: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous, color: Colors.white)),
                IconButton(
                    onPressed: () {
                      _controller!.value.isPlaying
                          ? _controller!.pause()
                          : _controller!.play();
                    },
                    icon: Icon(
                        _controller!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    )),
              ],
            )
          ],
        ));
  }
}
