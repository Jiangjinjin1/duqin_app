import 'package:flutter/material.dart';

class AppBarTestPage extends StatefulWidget {
  const AppBarTestPage({Key? key}) : super(key: key);

  @override
  _AppBarTestPageState createState() => _AppBarTestPageState();
}

class _AppBarTestPageState extends State<AppBarTestPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('appBar练习'),
            backgroundColor: Colors.red,
            leading: Icon(Icons.menu),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: '热门'),
                Tab(text: '推荐'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView(
                children: [
                  ListTile(
                    title: Text('第一个tab'),
                  ),
                  ListTile(
                    title: Text('第一个tab'),
                  ),
                  ListTile(
                    title: Text('第一个tab'),
                  ),
                  ListTile(
                    title: Text('第一个tab'),
                  ),
                ],
              ),
              ListView(
                children: [
                  ListTile(
                    title: Text('第二个tab'),
                  ),
                  ListTile(
                    title: Text('第二个tab'),
                  ),
                  ListTile(
                    title: Text('第二个tab'),
                  ),
                  ListTile(
                    title: Text('第二个tab'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
