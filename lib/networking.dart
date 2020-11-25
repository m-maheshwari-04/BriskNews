import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app/news.dart';

class NetworkHelper {
  NetworkHelper({this.url});
  final url;

  Future getData() async {
    //get is part of http package that we imported
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      final parsed = json.decode(data);
      return (parsed["articles"] as List)
          .map<News>((json) => new News.fromJson(json))
          .toList();
    } else {
      print(response.statusCode);
    }
  }
}
