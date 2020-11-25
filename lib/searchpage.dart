import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/complete_news.dart';
import 'package:news_app/topScrollContent.dart';
import 'news.dart';
import 'newsModel.dart';

var randomImage =
    'https://motionarray.imgix.net/preview-296133-cYWCYCbMTg-high_0000.jpg?w=660&q=60&fit=max&auto=format';

class SearchPage extends StatefulWidget {
  SearchPage({this.size});
  final size;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController controller = ScrollController();
  var news;

  int selectedIndex = 0;
  String search;

  Widget shortNews(int i) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (BuildContext context) => CompleteNews(
              title: news[i].title,
              imageUrl: news[i].urlToImage,
              content: news[i].description,
              url: news[i].url,
            ),
          ),
        );
      },
      child: Container(
        width: widget.size.width * .85,
        margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
        decoration: (BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xFFFFFFFF),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: news[i].title,
              child: Container(
                height: widget.size.width * .4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage((news[i].urlToImage != null)
                          ? news[i].urlToImage
                          : randomImage),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Text(
                news[i].title,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  Future fetching() async {
    return await NewsModel().getNews(search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e3236),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                child: ListTile(
                  leading: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    'news',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'KronaOne',
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Topic',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    search = value;
                  },
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                onPressed: () async {
                  List<News> newss = await fetching();
                  setState(() {
                    news = newss;
                  });
                },
                child: Text(
                  'Get News',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  // margin: EdgeInsets.only(top:10),
                  child: ListView.builder(
                    controller: controller,
                    itemCount: news != null ? news.length : 0,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: shortNews(index),
                      );
                    },
                  ),
                ),
              )
              // : Container(child: null),
            ],
          ),
        ),
      ),
    );
  }
}
