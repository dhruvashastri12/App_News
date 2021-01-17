import 'package:app_news/NetworkCall/NewsResponse.dart';
import 'package:app_news/NetworkCall/ResponseArticles.dart';
import 'package:app_news/Screens/DetailNewsListview.dart';
import 'package:app_news/Utils/colors.dart';
import 'package:flutter/material.dart';

class NewsListview extends StatelessWidget {
  final NewsResponse objNewsResponse;

  NewsListview(this.objNewsResponse);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: objNewsResponse.articles.length,
        itemBuilder: (BuildContext context, int index) {
          Articles ar = objNewsResponse.articles[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(6, 10, 6, 3),
            child: Card(
              color: AppColors.card_light_purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 3,
              child: InkWell(
                splashColor: AppColors.title_orange_purple,
                onTap: () {
                  print('$index got clicked');

                  Navigator.push(
                    context,

                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 1),
                      pageBuilder: (_, __, ___) => DetailNewsListview(objAr: ar,)),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(1, 1, 1, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 140,
                        width: 100,
                        child: Hero(
                            tag: ar,
                            child: ClipRRect(
                              child: Image(
                                image: ar.urlToImage == null
                                    ? NetworkImage('https://flutter.io/images/catalog-widget-placeholder.png')
                                    : NetworkImage(ar.urlToImage),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 2),
                        child: Text(ar.title,
                            style: new TextStyle(
                                color: AppColors.title_orange_purple,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(ar.source.name,
                            style: new TextStyle(
                                color: AppColors.source_white_purple,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
