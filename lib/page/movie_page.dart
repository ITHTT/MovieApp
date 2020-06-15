import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'movie_list_page.dart';

class MoviePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_MoviePageState();
}

class _MoviePageState extends State<MoviePage>{
  List<Map> _tabs=[{"最新电影":0},
              {"综合电影":1},
              {"欧美电影":2},
              {"国内电影":3},
              {"日韩电影":4}];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _tabs.length, 
      child: new Scaffold(
        appBar: AppBar(
          title: Text('电影天堂'),
          centerTitle: true,
          actions: <Widget>[

          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabs.map((e) => Tab(text: e.keys.first,)).toList()
          ),
        ),
        body: TabBarView(
          children: _tabs.map((e) => MovieListPage(e.values.first)).toList()
          ),
      ));
  }
  
}