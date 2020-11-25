import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/web_article.dart';

class CompleteNews extends StatelessWidget {
  CompleteNews({this.title, this.imageUrl, this.content, this.url});
  final String title;
  final String imageUrl;
  final String content;
  final String url;

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF25283D),
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: title,
                    child: Container(
                      height: size.height * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(60, 30)),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  title,
                  style: TextStyle(
                      height: 1.3,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      fontFamily: 'Cairo'),
                ),
              ),
              SizedBox(
                height: 8,
                width: size.width * .6,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 22, fontFamily: 'Commissioner'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (BuildContext context) => WebArticle(
                        url: url,
                      ),
                    ),
                  );
                },
                child: Image(
                  image: AssetImage('images/next.png'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
