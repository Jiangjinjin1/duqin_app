import 'package:flutter/material.dart';

class TestRouteJumpPage2 extends StatefulWidget {
  const TestRouteJumpPage2({Key? key}) : super(key: key);

  @override
  _TestRouteJumpPage2State createState() => _TestRouteJumpPage2State();
}

class _TestRouteJumpPage2State extends State<TestRouteJumpPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二个测试路由页面'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('第二个tab页面'),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('正常返回按钮'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false, arguments: {'selectIndex': 2});
                    },
                    child: Text('返回根页面指定tab'),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
