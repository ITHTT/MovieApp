import 'package:MovieApp/model/movie_detail_model.dart';
import 'package:MovieApp/model/movie_list_model.dart';
import 'package:MovieApp/util/log_util.dart';
import 'package:dio/dio.dart';
import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:html/parser.dart';

import 'http_util.dart';

class MovieApi{

  //获取电影列表
  static void getMovieList(String url,{Function(MovieListModel)success,Function(String error) error}) async{
    var dio=HttpUtil.getDioInstance();
    try{
        Log.d("request_url:$url");
        Response<List<int>> response = await dio.get<List<int>>(url,options: Options(responseType: ResponseType.bytes));
        if(response.statusCode==200){
          var data=gbk.decode(response.data);
          var document=parse(data);
          var contents=document.getElementsByClassName("co_content8");
          if(contents.isNotEmpty){
            if(success!=null) success(MovieListModel.fromHtml(contents[0]));
          }else{
            if(success!=null) success(null);
          }
        }else{
          throw Exception('statusCode:${response.statusCode}');
        }
    }on DioError catch (e){
      if(error!=null){
        error(e.message);
      }
    }
  }

  static String getMovieListUrl(int type,int pageNo){
    switch(type){
      case 1:
         //综合电影
         return pageNo<=1 ? "https://www.dytt8.net/html/gndy/jddy/index.html":
                           "https://www.dytt8.net/html/gndy/jddy/list_63_$pageNo.html";
      case 2:
         //欧美电影
         return pageNo<=1 ? "https://www.dytt8.net/html/gndy/oumei/index.html":
                           "https://www.dytt8.net/html/gndy/oumei/list_7_$pageNo.html";
      case 3:
         //国内电影
         return pageNo<=1 ? "https://www.dytt8.net/html/gndy/china/index.html":
                           "https://www.dytt8.net/html/gndy/china/list_4_$pageNo.html";
      case 4:
         //日韩电影
         return pageNo<=1 ? "https://www.dytt8.net/html/gndy/rihan/index.html":
                           "https://www.dytt8.net/html/gndy/rihan/list_6_$pageNo.html";
      default:
         return pageNo<=1 ? "https://www.dytt8.net/html/gndy/dyzz/index.html":
                           "https://www.dytt8.net/html/gndy/dyzz/list_23_$pageNo.html";
    }
  }

  static void getMovieDetail(String url,{Function(MovieDetailModel)success,Function(String error) error}) async {
    var dio=HttpUtil.getDioInstance();
    try{
      Log.d("request_url:$url");
      Response<List<int>> response = await dio.get<List<int>>(url,options: Options(responseType: ResponseType.bytes));
      if(response.statusCode==200){
          var data=gbk.decode(response.data);
          var document=parse(data);
          var contents=document.getElementsByClassName("bd3");
          if(contents.isNotEmpty){
            if(success!=null) success(MovieDetailModel.fromHtml(contents[0]));
          }else{
            if(success!=null) success(null);
          }
        }else{
          throw Exception('statusCode:${response.statusCode}');
        }
    }on DioError catch(e){
      if(error!=null){
        error(e.message);
      }
    }
  }

}

