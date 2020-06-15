import 'package:MovieApp/util/image_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateLayout extends StatefulWidget{
  final StateType type;
  final String hintText;

  const StateLayout({
    Key key,
    @required this.type,
    this.hintText
  }):super(key:key);

  @override
  State<StatefulWidget> createState() => _StateLayoutState();
}

class _StateLayoutState extends State<StateLayout>{
  String _img;
  String _hintText;

  @override
  Widget build(BuildContext context) {
    switch(widget.type){
      case StateType.loading:
        _img='';
        _hintText='加载中...';
        break;
      case StateType.empty:
        _img='load_empty';
        _hintText="空空如也";
        break;
      case StateType.error:
         _img='load_fail';
         _hintText="加载失败";
         break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if(widget.type==StateType.loading)
          const CupertinoActivityIndicator(radius:12.0)
        else 
          Container(
             height: 120.0,
             width: 120.0,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: ImageUtil.getAssetImage('state/$_img'),
                ),
          ),),
        const SizedBox(width: double.infinity, height: 16.0),
        Text(
          widget.hintText ?? _hintText,
          style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 14.0),
        ),
      ],
    );
  }
}

enum StateType{
  //加载中
  loading,
  //数据为空
  empty,
  //出错
  error
}