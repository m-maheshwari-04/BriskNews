class News {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;

  News({this.author, this.title, this.description, this.url, this.urlToImage});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        author: json['author'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['read-more'] as String,
        urlToImage: json['image'] as String);
  }
}
