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

// Create a new Class for assigning the vars to the JSON Decode
class Item {
  var product_name;
  var description;
  var images;

  Item(var product_name, var description, var images) {
    this.product_name = product_name;
    this.description = description;
    this.images = images;
  }

  Item.fromJson(Map json)
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

// Fetch the data in the URl as a JSON
class API {
  static Future getUsers() {
    var url =
        "https://raw.githubusercontent.com/BullsEye34/inspiredKinematicsTest/master/assets/product.json"; // Had to Use Raw OF JSON from Github Repo.
    print(http.get(url));
    return http.get(url);
  }
}

class _appState extends State<app> {
  var items = new List<Item>();
  _getUsers() {
    API.getUsers().then((response) {
      var o = response;
      o = o.body.toString();
      setState(() {
        Iterable list = json.decode(o);
        items = list.map((model) => Item.fromJson(model)).toList();
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
                    // Can use a StreamBuilder too
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(
                                  items[index].images[index].toString(),
                                ),
                              ),
                            ),
                            height: h / 1.2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // That White Line
                                  VerticalDivider(
                                    indent: h / 1.42,
                                    endIndent: 1,
                                    color: Colors.black, // Had to make it black
                                    thickness: 2,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Title Text
                                        Flexible(
                                          child: Text(
                                            items[index]
                                                .product_name
                                                .toString()
                                                .toUpperCase(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(
                                                  72), // 72 from design Guidelines
                                              color: Colors
                                                  .grey, // Had to make it Grey from White
                                            ),
                                          ),
                                        ),
                                        // Description text
                                        Flexible(
                                          child: Text(
                                            items[index]
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              // Usually, I think that the logos would be on the images itself.
              Positioned(
                top: h / 80,
                left: w / 1.5,
                child: Image.asset(
                  'assets/MOB_ VAPHlogo.png',
                  height: 50,
                  color: Colors.black,
                ),
              ),
              Positioned(
                bottom: h / 17,
                child: Image.asset(
                  'assets/MOB_ Aneclogo.png',
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
