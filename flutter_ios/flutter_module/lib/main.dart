import 'package:flutter/material.dart';
import 'package:flutter_module/testpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

/// 静态的首页
/// 不需要变更使用 StatelessWidget
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("夏天然后"),
      ),
      body: Center(
        child: _setupContainer(),
      ),
    );
  }
}

/*
alignment：控制child的对齐方式
padding：容器本身的内边距
color：容器的背景色
decoration：容器的样式，类似于css的style
foregroundDecoration：容器的前景色，可能会遮盖color效果
width：容器的宽度
height：容器的高度
constraints：容器的约束，约束宽高的大小
margin：容器本身的外边距
transform：容器的变换矩阵，可以让容器的缩放、旋转、平移等
child：容器的子控件
*/
Widget _setupContainer() {
  return Container(
    constraints: BoxConstraints.expand(
      height: 667,
    ),
    padding: EdgeInsets.all(8.0),
    child: CenterColumnRoute(),
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

class CenterColumnRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // 自定义样式文本
        Text(
          "hi",
          style: TextStyle(
              color: Colors.purple,
              fontSize: 25.0,
              height: 1.2,
              fontFamily: "Courier",
              background: Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed),
        ),
        // 普通文本
        Text("world"),
        // 漂浮按钮
        ElevatedButton(
          child: Text("normal"),
          onPressed: () {},
        ),
        // 文本按钮
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
            print("按钮点击");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return NewRoute();
              }),
            );
          },
        ),
        // 输入框
        TextField(
          autofocus: true,
          onChanged: (v) {
            print("onChange: $v");
          },
          decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              prefixIcon: Icon(Icons.person)),
        ),
        Wrap(
          spacing: 8.0, // 主轴(水平)方向间距
          runSpacing: 4.0, // 纵轴（垂直）方向间距
          alignment: WrapAlignment.center, //沿主轴方向居中
          children: <Widget>[
            Chip(
              avatar:
                  CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
              label: Text('Hamilton'),
            ),
            Chip(
              avatar:
                  CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
              label: Text('Lafayette'),
            ),
            Chip(
              avatar:
                  CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
              label: Text('Mulligan'),
            ),
            Chip(
              avatar:
                  CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
              label: Text('Laurens'),
            ),
            Flow(
              delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.red,
                ),
                Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.green,
                ),
                Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.blue,
                ),
                Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.yellow,
                ),
                Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.brown,
                ),
                Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.purple,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  TestFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
