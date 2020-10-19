import 'package:app_news/NetworkCall/NewsResponse.dart';
import 'package:flutter/material.dart';
import 'package:app_news/NetworkCall/ResponseArticles.dart';

class DetailNewsListview extends StatefulWidget {

  NewsResponse _objDetailNewsResponse;
  // ResponseArticles _objDetailResponseArticles;

  DetailNewsListview(NewsResponse objDetailNewsResponse){
    _objDetailNewsResponse = objDetailNewsResponse;
  }

  @override
  _DetailNewsListviewState createState() => _DetailNewsListviewState(_objDetailNewsResponse);
}

class _DetailNewsListviewState extends State<DetailNewsListview> {

  NewsResponse objDetailNewsResponse;

  _DetailNewsListviewState(NewsResponse objDetailNewsResponse){
    this.objDetailNewsResponse = objDetailNewsResponse;
    print(objDetailNewsResponse.articles[0].title);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
          image: NetworkImage(
              'https://flutter.io/images/catalog-widget-placeholder.png')),
    );
  }
}
