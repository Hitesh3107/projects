import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Bendu());
}

class Bendu extends StatefulWidget {
  @override
  _BenduState createState() => _BenduState();
}

class _BenduState extends State<Bendu> {
  var fsc = FirebaseFirestore.instance;
  String x;
  var data;
  myweb(cmd) async {
    print(cmd);
    var url = "http://192.168.0.105/cgi-bin/output1.py?x=${cmd}";
    var r = await http.get(url);
    // var sc = r.statusCode;
    setState(() {
      data = r.body;
    });

    var d = fsc.collection("output").add({
      x: data,
    });

    print(data);
  }

  mybody() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amber,
          image: DecorationImage(
              image: AssetImage("images/firebase.png"), fit: BoxFit.fill)),
      child: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          //color: Colors.amber,
          height: 250,
          width: 250,
          //decoration: BoxDecoration(
          //  color: Colors.amber,
          // image: DecorationImage(
          //   image: AssetImage("images/bendumain.png"), fit: BoxFit.fill)),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 700,
              width: 300,
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Card(
                      child: TextField(
                    autocorrect: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "CHECK COMMAND ",
                        hoverColor: Colors.blue,
                        prefixIcon: Icon(Icons.tablet_android)),
                    onChanged: (val) {
                      x = val;
                      // print(val);
                    },
                  )),
                  Card(
                    child: FlatButton(
                        onPressed: () {
                          // print(x);
                          myweb(x);
                        },
                        child: Text(
                          "CHECK THE OUTPUT",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        )),
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Colors.red[900],
                          Colors.purple[600],
                          Colors.deepPurple[900],
                        ])),
                    child: Text(
                      data ?? "output is coming",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: Image.asset("images/firebase.png"),
        actions: <Widget>[Icon(Icons.home)],
        title: Center(
          child: Text(
            "Linux App",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: mybody(),
    ));
  }
}
