import 'package:app_news/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_news/NetworkCall/ResponseArticles.dart';

class DetailNewsListview extends StatefulWidget {
  final Articles objAr;
  DetailNewsListview({@required this.objAr});

  @override
  _DetailNewsListviewState createState() => _DetailNewsListviewState();
}

class _DetailNewsListviewState extends State<DetailNewsListview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.back_dark_purple,
      appBar: AppBar(
        title: Text(
          widget.objAr.source.name,
          style: TextStyle(color: AppColors.source_white_purple),
        ),
        backgroundColor: AppColors.card_light_purple,
      ),

      body: Column(
        children: [   
          SizedBox(height: 10.0,),       
          Hero(
            tag: widget.objAr,
                      child: Image(
                image: widget.objAr.urlToImage == null
                    ? NetworkImage('https://flutter.io/images/catalog-widget-placeholder.png')
                    : NetworkImage(widget.objAr.urlToImage)),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.objAr.title, style: TextStyle(color: AppColors.title_orange_purple, fontSize: 18.0, fontWeight: FontWeight.bold)),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.objAr.description, style: TextStyle(color: AppColors.source_white_purple, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
