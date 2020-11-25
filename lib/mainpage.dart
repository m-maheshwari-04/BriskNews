import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/complete_news.dart';
import 'package:news_app/topScrollContent.dart';
import 'newsModel.dart';
import 'searchpage.dart';

var randomImage =
    'https://motionarray.imgix.net/preview-296133-cYWCYCbMTg-high_0000.jpg?w=660&q=60&fit=max&auto=format';

class MainPage extends StatefulWidget {
  MainPage({this.news, this.size});
  final news;
  final size;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController controller = ScrollController();
  var news;

  int selectedIndex = 0;
  Widget topScrollItems(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          news = newsList[index];
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data[index].title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color:
                      selectedIndex == index ? Color(0xFFFFFFFF) : Color(0xFF898989)),
            ),
            Container(
              decoration: BoxDecoration(
                color: selectedIndex == index ? Colors.white70 : Colors.transparent,
                borderRadius: BorderRadius.all( Radius.circular(30.0)),
              ),
              margin: EdgeInsets.only(top: 7),
              height: 6,
              width: (data[index].title.length*6.0),
            )
          ],
        ),
      ),
    );
  }

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
                style: TextStyle(fontSize: 18,color:Colors.black),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  var newsList = [];

  @override
  void initState() {
    super.initState();
    news = widget.news;
    newsList.add(news);
    fetching();
    controller.addListener(() {
      setState(() {});
    });
  }

  void fetching() async {
    var now = new DateTime.now();
    print(now);

    var dataFetch = [];
    for (var i = 1; i <= 9; i++) {
      dataFetch.add(NewsModel().getNews(data[i].urlCategory));
    }

    for (var i = 0; i < 9; i++) {
      newsList.add(await dataFetch[i]);
      now = new DateTime.now();
      print(now);
    }
  }

  @override
  void dispose() {
    super.dispose();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e3236),
      //25283D
      //x2d98f8
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                child: ListTile(
                  title: Text(
                    '  news',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'KronaOne',
                      fontSize: 35,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SearchPage(size: widget.size);
                      }));
                    },
                    child: Icon(
                      Icons.search,
                      size: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) => topScrollItems(index)),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: newsList[selectedIndex].length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: shortNews(index),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
changing visibility of horizontal scroll on scrolling down

AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: closeTopContainer ? 0 : 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: size.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer ? 0 : 50,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Row(
                        children: <Widget>[
                          TopScroll(
                              color: Colors.orange.shade400, title: "Top News",onpressed: () async {
                            var newsData =
                            await NewsModel().getTopNews();
                            getPostsData(newsData);
                          }),
                          TopScroll(
                              color: Colors.lightBlueAccent.shade400,
                              title: "National",
                              onpressed: () async {
                                var newsData =
                                    await NewsModel().getNews('national');
                                getPostsData(newsData);
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),




class TopScroll extends StatelessWidget {
  TopScroll({this.color, this.title, this.onpressed});
  final Color color;
  final String title;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(16.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      onPressed: onpressed,
    );
  }
}

 */

/*
decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
                color: CupertinoColors.black,
                offset: Offset(4.0, 4.0),
                spreadRadius: 1.0)
          ]),
 */

/*
child: Container(
            height: size.width * .57,
            width: size.width * .85,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Stack(
              children: [
                Hero(
                  tag: widget.news[i].title,
                  child: Container(
                    height: size.width * .5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(
                              (widget.news[i].urlToImage != null)
                                  ? widget.news[i].urlToImage
                                  : randomImage),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                        height: size.width * .37,child: null),
                    Container(
                      alignment: Alignment.center,
                      width: size.width * .80,
                      height: size.width*.20,
                      decoration: (BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFFFFFFFF),
                        boxShadow:[
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: 50,
                            offset: new Offset(-5.0,0.0),
                          )
                        ],
                      )),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        widget.news[i].title,
                        style: TextStyle(fontSize: 20,

                        color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),


 */
