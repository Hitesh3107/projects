import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(VideoApp());

class VideoApp extends StatefulWidget {
  VideoApp() : super();

  final String title = "Video App";
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
  Future<void> _intializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      "assets/benduvideo.mp4",
    );
    _intializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.amber);
    ti() {
      Fluttertoast.showToast(
        msg: "List is loading",
        gravity: ToastGravity.BOTTOM_LEFT,
        fontSize: 20.0,
        textColor: Colors.black87,
        toastLength: Toast.LENGTH_SHORT,
      );
    }

    t2() {
      Fluttertoast.showToast(
        msg: "power off",
        gravity: ToastGravity.BOTTOM_LEFT,
        fontSize: 20.0,
        textColor: Colors.black87,
        toastLength: Toast.LENGTH_SHORT,
      );
    }

    var appBar2 = AppBar(
      leading: IconButton(icon: Icon(Icons.list), onPressed: ti),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.settings_power), onPressed: t2)
      ],
      title: Text(" video app"),
      backgroundColor: Colors.red.shade500,
    );
    return MaterialApp(
      home: Scaffold(
        appBar: appBar2,
        body: Center(
          child: Container(
            height: 400,
            width: 300,
            margin: EdgeInsets.all(30),
            color: Colors.red,
            child: Container(
              height: 200,
              width: 150,
              color: Colors.amber,
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 300,
                    child: FutureBuilder(
                        future: _intializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                  //slider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        padding: EdgeInsets.only(
                            top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                        onPressed: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          });
                        },
                        child: Text(
                          "       Pause",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54),
                        ),
                      ),
                      RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        padding: EdgeInsets.only(
                            top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                        onPressed: () {
                          setState(() {
                            _controller.play();
                          });
                        },
                        child: Text(
                          "        Play",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade300,
        /*FutureBuilder(
          future: _intializeVideoPlayerFuture,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done)
            {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
                );
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),*/
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
