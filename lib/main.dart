import 'package:flutter/material.dart';
import 'package:app_news/NetworkCall/NewsResponse.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

void main() => runApp(MyApp());

// newsapi.org
final String news_api_key = "08bdb51e8da54f44bec8fc0f923cc437";
final String news_url =
    "http://newsapi.org/v2/top-headlines?country=us&apiKey=08bdb51e8da54f44bec8fc0f923cc437";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
      objNewsResponse =
          NewsResponse.fromJson(json.decode(receivedNewsResponse.body));
      print(receivedNewsResponse.body);
      print(objNewsResponse.totalResults);
      print(objNewsResponse.articles.length);
      print('Source name: ${objNewsResponse.articles[0].source.name}');
      print('Title: ${objNewsResponse.articles[0].title}');
      print('Image: ${objNewsResponse.articles[0].urlToImage}');

      // print(objdecodedNewsResponse['totalResults']);
      // print('decoded source name: ${objdecodedNewsResponse['articles'][itemIndex]['source']['name']}');
      // print('decoded title: ${objdecodedNewsResponse['articles'][itemIndex]['title']}');
      // print('decoded image url: ${objdecodedNewsResponse['articles'][itemIndex]['urlToImage']}');
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
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber[200],
      ),
      body: objNewsResponse == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
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
                              image: (objNewsResponse.articles[index].urlToImage) == null ? 
                              DecorationImage(image: NetworkImage('https://flutter.io/images/catalog-widget-placeholder.png'),fit: BoxFit.fill)
                                  : DecorationImage(
                                      image: NetworkImage(objNewsResponse.articles[index].urlToImage),
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
                          child: Text(
                              objNewsResponse.articles[index].source.name,
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
          }),
    );
  }
}
