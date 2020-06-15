import 'package:MovieApp/util/log_util.dart';
import 'package:html/dom.dart';

class MovieDetailModel{
  String movieTitle;
  String publisTime;
  String movieInfo;
  String downloadUrl;

  MovieDetailModel.fromHtml(Element content){
    var title=content.getElementsByClassName("title_all")[0].text;
    Log.d("movie_title：$title");
    this.movieTitle=title;

    var contentTag=content.getElementsByClassName("co_content8")[0];
    var time=contentTag.getElementsByTagName("ul")[0].text;
    Log.d("publish_time：$time");
  }
}