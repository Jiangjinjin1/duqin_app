

import 'package:flutter/material.dart';

class TabBarControllerPage extends StatefulWidget {
  const TabBarControllerPage({Key? key}) : super(key: key);

  @override
  _TabBarControllerPageState createState() => _TabBarControllerPageState();
}

class _TabBarControllerPageState extends State<TabBarControllerPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      vsync: this,
      length: 2,
    );

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tabBarController测试'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.red,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: <Widget>[
            Tab(text: '热门'),
            Tab(text: '推荐'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Text('热门'),
          ),
          Center(
            child: Text('推荐'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
}
