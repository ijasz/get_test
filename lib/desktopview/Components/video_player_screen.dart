import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  String video;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  final _firestore = FirebaseFirestore.instance;

  List<String> addvideo = [];

  getVideo() async {
    final message = await _firestore.collection('Video').get();

    //print(courses.data()['img']);
    for (var i in message.docs) {
      var docs = i.data()["Video"];
      addvideo.add(docs);
    }

    //Provider.of<VideoLink>(context, listen: false).updateValue(video);

    setState(() {
      _controller = VideoPlayerController.network(
        '${addvideo[0]}',
      );

      // Initielize the controller and store the Future for later use.
      _initializeVideoPlayerFuture = _controller.initialize();

      // Use the controller to loop the video.
      _controller.setLooping(true);
      //print(video);
    });
  }

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      '',
    );
    getVideo();
    super.initState();
    print(video);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
            child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: ClipRRect(
                  child: VideoPlayer(_controller),
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return Center(child: CircularProgressIndicator());
            }
          },
        )),
        Center(
            child: RaisedButton(
          elevation: 0,
          color: Colors.transparent,
          textColor: Colors.white,
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
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            size: 120.0,
          ),
        ))
      ],
    );
  }
}
