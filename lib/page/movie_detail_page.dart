import 'package:MovieApp/network/movie_api.dart';
import 'package:MovieApp/util/log_util.dart';
import 'package:MovieApp/widget/state_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget{
  final BuildContext context;

  MovieDetailPage({this.context});
 
  @override
  State<StatefulWidget> createState() => _MovieDetailPageState(context: this.context);
  
}

class _MovieDetailPageState extends State<MovieDetailPage>{
  final BuildContext context;
  String _url;

  _MovieDetailPageState({this.context});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Log.d("电影详情界面....");
    if(context!=null){
      Log.d("获取数据...");
      dynamic obj=ModalRoute.of(context).settings.arguments;
      if(obj!=null&&obj['url']!=null){
        _url=obj['url'];
        Log.d('url:$_url');
        if(!_url.startsWith("http://")&&!_url.startsWith("https://")){
          _url="https://www.dytt8.net$_url";
        }
        getMovieDetail();
      }
    }
  }

  void getMovieDetail(){
    MovieApi.getMovieDetail(_url,success:(data){

    },
    error:(msg){

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('电影详情'),
        centerTitle: true,
      ),
      body: StateLayout(type: StateType.loading),
    );
  }
  
}