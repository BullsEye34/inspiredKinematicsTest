import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: app(),
    ),
  );
}

class app extends StatefulWidget {
  @override
  _appState createState() => _appState();
}

class _appState extends State<app> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    print(h);
    return SafeArea(
      child: Container(
        color: Color(0x111f1b24), // Kinda grey Color
        child: Stack(
          // Thinking of Stacking up image and text and other stuff
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15, // 15 means 45px
                vertical: 13.333, // 13.333 menas 40px
              ),
              child: Container(
                color: Colors.white,
                height: h / 1.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
