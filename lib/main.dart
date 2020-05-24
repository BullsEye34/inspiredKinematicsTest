import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      // print(o.body.toString());
      o = o.body.toString();
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
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Color(0x111f1b24),
      body: SafeArea(
        child: Container(
          // Kinda grey Color
          child: Stack(
            // Thinking of Stacking up image and text and other stuff
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15, // 15 means 45px
                  vertical: 13.333, // 13.333 menas 40px
                ),
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(
                              users[index].images[index].toString(),
                            ),
                          ),
                        ),
                        // color: Colors.white,
                        height: h / 1.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                users[index]
                                    .product_name
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil()
                                        .setSp(72), // 72 from design Guidelines
                                    color: Colors.grey),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                users[index]
                                    .description[index]
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
