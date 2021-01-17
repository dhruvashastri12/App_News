import 'package:app_news/Screens/NewsListview.dart';
import 'package:app_news/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_news/NetworkCall/NewsResponse.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

void main() => runApp(MyApp());

// newsapi.org
final String news_api_key = "08bdb51e8da54f44bec8fc0f923cc437";
final String news_url = "http://newsapi.org/v2/top-headlines?country=us&apiKey=08bdb51e8da54f44bec8fc0f923cc437";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'News App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int firstIndex = 0;

  NewsResponse objNewsResponse;

  @override
  void initState() {
    super.initState();
    fetchData(firstIndex);
  }

  void fetchData(int itemIndex) async {
    var receivedNewsResponse = await get(news_url);
    if (receivedNewsResponse.statusCode == 200) {
      objNewsResponse = NewsResponse.fromJson(json.decode(receivedNewsResponse.body));
      
      print(receivedNewsResponse.body);
      print(objNewsResponse.totalResults);
      print(objNewsResponse.articles.length);
      print('Source name: ${objNewsResponse.articles[0].source.name}');
      print('Title: ${objNewsResponse.articles[0].title}');
      print('Image: ${objNewsResponse.articles[0].urlToImage}');
    } else {
      throw Exception('Failed to load album');
    }
    setState(() {
      print("Set state from fetchData");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.back_dark_purple,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: AppColors.source_white_purple),
        ),
        backgroundColor: AppColors.card_light_purple,
      ),
      body: objNewsResponse == null
          ? Center(child: CircularProgressIndicator(),)
          : NewsListview(objNewsResponse)
    );
  }
}
