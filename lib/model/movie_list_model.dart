import 'package:html/dom.dart';

import 'movie_model.dart';

class MovieListModel{
  List<MovieModel> data;

  MovieListModel(this.data);

  MovieListModel.fromHtml(Element content){
     var items=content.getElementsByTagName("table");
     var list=List<MovieModel>();
     for(var item in items){
       list.add(MovieModel.fromHtml(item));
     }
     this.data=list;
  }

  bool isEmpty() => data==null||data.isEmpty;

  Map toJson(){
    Map map=new Map();
    map["data"]=this.data;
    return map;
  }
  
}