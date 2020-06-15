import 'package:MovieApp/page/movie_page.dart';
import 'package:MovieApp/route_provider.dart';
import 'package:MovieApp/util/device_util.dart';
import 'package:MovieApp/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(MyApp());
  // 透明状态栏
  if (DeviceUtil.isAndroid) {
    final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {

  MyApp(){
    Log.init();
  }
 
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
         title: 'MovieApp',
         theme: ThemeData(
              primarySwatch: Colors.blue,
              // This makes the visual density adapt to the platform that you run
              // the app on. For desktop platforms, the controls will be smaller and
              // closer together (more dense) than on mobile platforms.
              visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: RouteProvider.getAppRoutes(context),
          //initialRoute: '/movie_page',
          home: MoviePage(),
      )
    );
  }
}