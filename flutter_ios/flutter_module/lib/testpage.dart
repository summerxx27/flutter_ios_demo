import 'package:flutter/material.dart';

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
    child: Text("第二页"),
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
