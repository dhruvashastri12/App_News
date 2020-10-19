import 'package:app_news/NetworkCall/NewsResponse.dart';
import 'package:app_news/Screens/DetailNewsListview.dart';
import 'package:flutter/material.dart';

class NewsListview extends StatelessWidget {
  final NewsResponse objNewsResponse;

  NewsListview(this.objNewsResponse);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: objNewsResponse.articles.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(6, 10, 6, 3),
            child: Card(
              color: Colors.amber[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 3,
              child: InkWell(
                splashColor: Colors.greenAccent,
                onTap: () {
                  print('$index got clicked');
                  // Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Hello!')));
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "$index got clicked",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => 
                        DetailNewsListview(objNewsResponse.articles[index])),
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
                          decoration: BoxDecoration(
                            image: (objNewsResponse
                                        .articles[index].urlToImage) ==
                                    null
                                ? DecorationImage(
                                    image: NetworkImage(
                                        'https://flutter.io/images/catalog-widget-placeholder.png'),
                                    fit: BoxFit.fill)
                                : DecorationImage(
                                    image: NetworkImage(objNewsResponse
                                        .articles[index].urlToImage),
                                    fit: BoxFit.fill,
                                  ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 2),
                        child: Text(objNewsResponse.articles[index].title,
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(objNewsResponse.articles[index].source.name,
                            style: new TextStyle(
                                color: Colors.black87,
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
