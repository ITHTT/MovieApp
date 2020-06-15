import 'package:MovieApp/model/movie_list_model.dart';
import 'package:MovieApp/model/movie_model.dart';
import 'package:MovieApp/network/movie_api.dart';
import 'package:MovieApp/util/log_util.dart';
import 'package:MovieApp/widget/state_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:convert' as convert;

class MovieListPage extends StatefulWidget{
  
  final int type;

  MovieListPage(this.type,{Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage>with AutomaticKeepAliveClientMixin{
  //初始化数据模型
  MovieListModel _movieList=MovieListModel([]);

  RefreshController _refreshController =RefreshController(initialRefresh: false);

  StateType _stateType = StateType.loading;
  int _pageNo=1;

  @override
  void initState() {
    super.initState();
    getMovieList(1);
  }

  void getMovieList(int pageNo){
      MovieApi.getMovieList(
            MovieApi.getMovieListUrl(widget.type, pageNo),
            success: (movieList){
              if(pageNo>1){
                _refreshController.loadComplete();
              }else{
                _refreshController.refreshCompleted();
              }
              if(movieList!=null){
                Log.json(convert.jsonEncode(movieList));
                setState(() {
                  if(pageNo==1){
                    this._movieList=movieList;
                    _pageNo=2;
                  }else{
                    this._movieList.data.addAll(movieList.data);
                    _pageNo++;
                  }
                });
              }else{
                if(_movieList.isEmpty()){
                  setState(() {
                    _stateType=StateType.empty;
                  });
                }else{
                  _refreshController.loadNoData();
                }
              }
            },
            error: (error){
              print("$error");
              if(_movieList.isEmpty()){
                setState(() {
                  _stateType=StateType.error;
                });
              }else{
                if(pageNo>1){
                  _refreshController.loadFailed();
                }else{
                  _refreshController.refreshFailed();
                }
              }
            }
          );
  }

  @override
  bool get wantKeepAlive => true;

  void _onRefresh(){
    //刷新方法
    getMovieList(1);
  }

  void _onLoadMore(){
    //加载更多
    Log.d("加载更多：$_pageNo");
    getMovieList(_pageNo);
  }

  
  @override
  Widget build(BuildContext context) {
    Log.d('_type：${widget.type}');
    
    return _movieList.isEmpty()?
           StateLayout(type: _stateType) :
           SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: MaterialClassicHeader(),
            footer: CustomFooter(
              builder: (BuildContext context,LoadStatus mode){
                Widget body ;
                if(mode==LoadStatus.idle){
                  body =  Text("上拉加载");
                }
                else if(mode==LoadStatus.loading){
                  body =  CupertinoActivityIndicator();
                }
                else if(mode == LoadStatus.failed){
                  body = Text("加载失败！点击重试！");
                }
                else if(mode == LoadStatus.canLoading){
                  body = Text("松手,加载更多!");
                }
                else{
                  body = Text("没有更多数据了!");
                }
                return Container(
                  height: 45.0,
                  child: Center(child:body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoadMore,
            child: ListView.builder(
              itemBuilder:(context,index) => _movieItemWidget(context,_movieList.data, index),
              itemCount: _movieList.data.length,
            ),
          );
  }

  Widget _movieItemWidget(BuildContext context,List<MovieModel>list,int index){
    return GestureDetector(
      onTap:(){
        showToast('点击第$index项');
        Navigator.pushNamed(context, '/movie_detail_page',
                           arguments:<String,String>{'url':list[index].movieUrl});      
      },
      child:Container(
        padding: EdgeInsets.only(top:5.0,bottom:5.0,left: 10.0,right: 10.0),
        decoration: BoxDecoration(
          color:Colors.white,
          border:Border(
            bottom: BorderSide(width:1.0,color:Colors.black12))
        ),
        child: Column(
          children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child:Text(
                  list[index].movieName,
                  style: TextStyle(fontSize: 16,color:Colors.black87),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:3.0,bottom:3.0),
                alignment: Alignment.topLeft,
                child: Text(
                  '日期：${list[index].movieDate}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize:12,color:Colors.cyan),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  list[index].movieBrief,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13,color:Colors.grey),
                )
              )
            ],
        ),
      )
    );
  }

}