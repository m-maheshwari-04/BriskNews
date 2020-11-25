import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/mainpage.dart';
import 'package:news_app/newsModel.dart';

Size size;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() async {
    var newsData = await NewsModel().getNews('all');

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainPage(news: newsData,size: size,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.grey,
          size: 100.0,
        ),
      ),
    );
  }
}
