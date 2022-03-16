import 'package:duqin_app/components/PreferredTabBar.dart';
import 'package:duqin_app/components/RootPageHead.dart';
import 'package:flutter/material.dart';


// tabbar
const List<Widget> _tabs = [
  const Tab(text: '微读'),
  const Tab(text: '推荐'),
  const Tab(text: '歌曲'),
  const Tab(text: '歌手'),
  const Tab(text: '小视频'),
  const Tab(text: '听书'),
  const Tab(text: '文章'),
  const Tab(text: '视频'),
  const Tab(text: '话题'),
];

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      initialIndex: 1,
      vsync: this,
      length: 9,
    );

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RootPageHead(),
        bottom: PreferredTabBar(
          tabController: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
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
          ListView(
            children: [
              ListTile(
                title: Text('第三个tab'),
              ),
            ],
          ),
          ListView(
            children: [
              ListTile(
                title: Text('第四个tab'),
              ),
            ],
          ),
          ListView(
            children: [
              ListTile(
                title: Text('第五个tab'),
              ),
            ],
          ),
          ListView(
            children: [
              ListTile(
                title: Text('第六个tab'),
              ),
            ],
          ),
          ListView(
            children: [
              ListTile(
                title: Text('第七个tab'),
              ),
            ],
          ),
          ListView(
            children: [
              ListTile(
                title: Text('第八个tab'),
              ),
            ],
          ),
          ListView(
            children: [
              ListTile(
                title: Text('第九个tab'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

