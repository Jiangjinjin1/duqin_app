import 'package:flutter/material.dart';


class TestRouteJumpPage extends StatefulWidget {
  Map? arguments;
  TestRouteJumpPage({Key? key, this.arguments}) : super(key: key);

  @override
  _TestRouteJumpPageState createState() => _TestRouteJumpPageState(arguments: arguments);
}

class _TestRouteJumpPageState extends State<TestRouteJumpPage> {
  Map? arguments;
  _TestRouteJumpPageState({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一个测试路由页'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('跳转测试${arguments!["id"] == null ? '' : arguments!["id"]}'),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/testRoute2');
                      // Navigator.pushNamed(context, '/testRoute2');
                    },
                    child: Text('替换路由测试'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/testRoute2');
                    },
                    child: Text('跳转下一个页面'),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
