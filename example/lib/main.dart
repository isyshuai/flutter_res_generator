import 'package:flutter/material.dart';
import 'res.g.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Image.asset(Res.gsws,height: 200,width: 200,),
              Image.asset(Res.gsws_xx,height: 200,width: 200),
              Image.asset(Res.gsws_xxx,height: 200,width: 200),
            ],
          ),
        ),
      ),
    );
  }
}
