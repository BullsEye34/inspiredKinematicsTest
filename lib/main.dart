import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: app(),
    ),
  );
}

class User {
  var product_name;
  var description;
  var images;

  User(var product_name, var description, var images) {
    this.product_name = product_name;
    this.description = description;
    this.images = images;
  }

  User.fromJson(Map json)
      : product_name = json['product_name'],
        description = json['description'],
        images = json['images'];

  Map toJson() {
    return {
      'product_name': product_name,
      'description': description,
      'images': images,
    };
  }
}

class app extends StatefulWidget {
  @override
  _appState createState() => _appState();
}

class API {
  static Future getUsers() {
    var url =
        "https://raw.githubusercontent.com/BullsEye34/inspiredKinematicsTest/master/assets/product.json";
    print(http.get(url));
    return http.get(url);
  }
}

class _appState extends State<app> {
  var users = new List<User>();
  _getUsers() {
    API.getUsers().then((response) {
      var o = response;
      print(o.body.toString());
      o = o.body.toString().substring(3);
      setState(() {
        Iterable list = json.decode(o);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    //print(h);

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
