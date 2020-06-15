import 'package:MovieApp/page/movie_detail_page.dart';
import 'package:MovieApp/page/movie_page.dart';
import 'package:flutter/cupertino.dart';

class RouteProvider{
  static Map<String,WidgetBuilder> getAppRoutes(BuildContext context){
    return {
      '/movie_page' : (context) => MoviePage(),
      '/movie_detail_page' : (context) => MovieDetailPage(context:context)
    };
  }
}