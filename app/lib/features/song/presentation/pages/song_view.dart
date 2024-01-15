import 'package:band_app/core/constants/environment.dart';
import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SongView extends StatefulWidget {
  final int id;

  const SongView({Key? key, required this.id}) : super(key: key);

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'http://${Environment.apiUrl}/songs/video/${widget.id}'
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      index: 2,
      title: const Text(
        "Písničky",
        style: TextStyle(
          fontSize: 20,
          color: Palette.first,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
        child: Column(
          children: [
            Card(
              color: Palette.fifth,
              child: ListTile(
                title: Text("Písnička ${widget.id}", textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Card(
                color: Palette.fifth,
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text("Písnička sssssssssss\nsssssssssssssssssssssssssssssssssssssssssssssss\nssssssssssssssssssssssssssssssssss\nssssssssssssssssssssssss\nsssssssssssss\nsss"),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the VideoPlayerController has finished initialization, use
                          // the data it provides to limit the aspect ratio of the video.
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            // Use the VideoPlayer widget to display the video.
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          // If the VideoPlayerController is still initializing, show a
                          // loading spinner.
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    ListTile(
                      title: IconButton(
                        icon: Icon(
                          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                        onPressed: () {
                          // Wrap the play or pause in a call to `setState`. This ensures the
                          // correct icon is shown.
                          setState(() {
                            // If the video is playing, pause it.
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              // If the video is paused, play it.
                              _controller.play();
                            }
                          });
                        },
                      ),
                    )
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Card(
                color: Palette.fifth,
                child: ListTile(
                  title: Column(
                    children: [
                      Slider(
                        allowedInteraction: SliderInteraction.slideThumb,
                        value: 0.5,
                        min: 0,
                        max: 1,
                        onChanged: (double value) {},
                        ),
                      Icon(Icons.play_arrow),
                    ],
                  ),
                  )
                ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Card(
                color: Palette.decline,
                  child: ListTile(
                    title: Text("Smazat", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Palette.white)),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
