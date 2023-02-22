import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image/flutter_image.dart';

class DioRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dio route"),
      ),
      body: Center(
        child: _setupContainer(),
      ),
    );
  }
}

Widget _setupContainer() {
  var futureBuilderRouteState = _FutureBuilderRouteState();
  return Container(
    constraints: BoxConstraints.expand(
      height: 667,
    ),
    padding: EdgeInsets.all(8.0),
    child: DioTestRoute(),
    alignment: Alignment.center,
    transform: Matrix4.identity(),
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        color: Color.fromARGB(255, 181, 231, 237),
        borderRadius: BorderRadius.circular(20.0)),
    foregroundDecoration: BoxDecoration(),
    height: 667,
    width: 375,
    //color: Colors.blue[200],
  );
}

class DioTestRoute extends StatefulWidget {
  @override
  _FutureBuilderRouteState createState() => _FutureBuilderRouteState();
}

class _FutureBuilderRouteState extends State<DioTestRoute> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              //发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              //请求成功，通过项目信息构建用于显示项目名称的ListView
              return ListView(
                children: response.data
                    .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                    .toList(),
              );
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}
