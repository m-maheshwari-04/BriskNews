import 'news.dart';

List<TopScrollData> data = [
  TopScrollData('Top News', 'all'),
  TopScrollData('National', 'national'),
  TopScrollData('Sports', 'sports'),
  TopScrollData('Entertainment', 'entertainment'),
  TopScrollData('Automobile', 'automobile'),
  TopScrollData('Business', 'business'),
  TopScrollData('Science', 'science'),
  TopScrollData('Startup', 'startup'),
  TopScrollData('Technology', 'technology'),
  TopScrollData('World', 'world'),
];

class TopScrollData {
  String title;
  String urlCategory;

  TopScrollData(this.title, this.urlCategory);
}
