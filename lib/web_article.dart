import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// void main() => runApp(new CompleteNews(null));

class WebArticle extends StatelessWidget {
  WebArticle({this.url});
  final String url;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
            "Full Article"
        ),
      ),
      body: new MaterialApp(
        routes: {
          "/": (_) => new WebviewScaffold(
            url: url,
            appBar: new AppBar(
              title: new Text("Article"),
            ),
          ),
        },
      ),
    );
  }
}
