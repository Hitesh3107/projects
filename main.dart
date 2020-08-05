import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

typedef void OnError(Exception exception);

void main() {
  runApp(
      new MaterialApp(debugShowCheckedModeBanner: false, home: LocalAudio()));
}

class LocalAudio extends StatefulWidget {
  @override
  _LocalAudio createState() => _LocalAudio();
}

class _LocalAudio extends State<LocalAudio> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  String localFilePath;

  Widget _tab(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: children
                .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _btn(String txt, VoidCallback onPressed) {
    return ButtonTheme(
      minWidth: 48.0,
      child: Container(
        width: 150,
        height: 45,
        child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Text(txt),
            color: Colors.orange[900],
            textColor: Colors.white,
            onPressed: onPressed),
      ),
    );
  }

  Widget LocalAudio() {
    return _tab([
      _btn('Play', () => audioCache.play('bendusong.wav')),
      _btn('Pause', () => advancedPlayer.pause()),
      _btn('Stop', () => advancedPlayer.stop()),
    ]);
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.amber);
    ti() {
      Fluttertoast.showToast(
        msg: "add the pic",
        gravity: ToastGravity.BOTTOM_LEFT,
        fontSize: 20.0,
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
      );
    }

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.toc), onPressed: ti),
          elevation: 1.0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.settings_power), onPressed: ti),
          ],
          backgroundColor: Colors.pink,
          title: Center(child: Text(' songs zone')),
        ),
        body: TabBarView(
          children: [LocalAudio()],
        ),
      ),
    );
  }
}
