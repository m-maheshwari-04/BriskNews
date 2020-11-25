import 'package:news_app/networking.dart';

import 'news.dart';

class NewsModel {
  Future<dynamic> getNews(String category) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: 'https://api.atik.cf/inshorts/$category');
    List<News> newsData = await networkHelper.getData();
    return newsData;
  }

}
