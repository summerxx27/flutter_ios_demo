import 'package:flutter/material.dart';
import 'package:flutter_module/diotest.dart';
import 'dart:convert';
import 'dart:io';

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: _setupContainer(),
      ),
    );
  }
}

Widget _setupContainer() {
  return Container(
    constraints: BoxConstraints.expand(
      height: 667,
    ),
    padding: EdgeInsets.all(8.0),
    child: HttpTestRoute(),
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

class HttpTestRoute extends StatefulWidget {
  @override
  _HttpTestRouteState createState() => _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TextButton(
            child: Text(
              "下一页",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 18.0,
                  height: 1.2,
                  fontFamily: "Courier",
                  background: Paint()..color = Colors.yellow,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return DioRoute();
                }),
              );
            },
          ),
          ElevatedButton(
            child: Text("获取github 数据"),
            onPressed: _loading ? null : request,
          ),
          Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("full_name: $_name"),
                    Text("分割线 #################"),
                    Text("json: $_text")
                  ]))
        ],
      ),
    );
  }

  request() async {
    setState(() {
      _loading = true;
      _text = "正在请求...";
      _name = "未获取";
    });
    try {
      //创建一个HttpClient
      HttpClient httpClient = HttpClient();
      //打开Http连接
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://api.github.com/users/mosn/repos?per_page=100&page=1"));
      //添加 headers
      // request.headers.add(
      //   "Authorization",
      //   "token ",
      // );
      //等待连接服务器（会将请求信息发送给服务器）
      HttpClientResponse response = await request.close();
      //读取响应内容
      _text = await response.transform(utf8.decoder).join();
      var jsonDecode = json.decode(_text);
      // print(jsonDecode);
      var obj = jsonDecode[0];
      print("测试");
      print(obj["full_name"]);
      _name = obj["full_name"];
      //关闭client后，通过该client发起的所有请求都会中止。
      httpClient.close();
    } catch (e) {
      _text = "请求失败：$e";
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
