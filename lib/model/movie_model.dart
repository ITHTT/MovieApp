import 'package:html/dom.dart';

class MovieModel{
  String movieName;
  String movieUrl;
  String movieDate;
  String movieBrief;

  MovieModel.fromHtml(Element item){
      var aTags=item.getElementsByTagName("a");
      var aTitleTag=aTags[aTags.length-1];

      movieUrl=aTitleTag.attributes["href"];
      movieName=aTitleTag.text;

      //解析日期
      var dateTag=item.getElementsByTagName("font")[0];
      var date=dateTag.text;
      date=date.replaceFirst("日期：", "").replaceAll("\n", "");
      movieDate=date;

      //解析简介
      var briefTags=item.querySelectorAll("td[colspan]");
      movieBrief=briefTags[briefTags.length-1].text;
  }

  Map toJson(){
    Map map=new Map();
    map["movieName"]=this.movieName;
    map["movieUrl"]=this.movieUrl;
    map["movieDate"]=this.movieDate;
    map["movieBrief"]=this.movieBrief;
    return map;
  }
  
}