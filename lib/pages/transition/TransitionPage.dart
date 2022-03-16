import 'dart:async';

import 'package:flutter/material.dart';

class TransitionPage extends StatefulWidget {
  const TransitionPage({Key? key}) : super(key: key);

  @override
  _TransitionPageState createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  late Timer _timer;
  int _currentTime = 6;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 1000), (t) {
      setState(() {
        _currentTime--;
      });
      if (_currentTime <= 0) {
        // 跳转首页
        t.cancel();  // 定时器内部触发销毁
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false, arguments: {'selectIndex': 0});
      }
    });
  }

  _toHomePage() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false, arguments: {'selectIndex': 0});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/common/page.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: _clipButton(),
          )
        ],
      ),
    );
  }

  Widget _clipButton() {
    return ClipOval(
      child: Container(
        width: 50,
        height: 50,
        color: Colors.black,
        child: InkWell(
          onTap: _toHomePage,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '跳过',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              Text(
                '${_currentTime}s',
                style: TextStyle(color: Colors.white, fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }
}
