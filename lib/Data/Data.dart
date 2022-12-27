import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Content>> getConent(String page) async {
  List<Content> contents;
  var respone = await http.get(Uri.parse('https://ittime.uz/back/$page'));
  var result = json.decode(respone.body);
  var results = result as List;
  contents = results.map<Content>((json) => Content.fromJson(json)).toList();
  return contents;
}

class Content {
  String title;
  String cover_img;
  String content;
  String voice_text;
  String the_topic;
  String author;

  String views;
  String tags;

  Content({
    required this.title,
    required this.cover_img,
    required this.content,
    required this.the_topic,
    required this.author,
    required this.views,
    required this.voice_text,
    required this.tags,
  });
  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      title: json['title'],
      cover_img: json['cover_img'],
      content: json['content'],
      the_topic: json['the_topic'],
      author: json['author'],
      views: json['views'],
      voice_text: json['voice_text'],
      tags: json['tags'],
    );
  }
}
