import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('第一个tab页面'),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/testRoute',
                          arguments: {"id": '958'});
                    },
                    child: Text('跳转到测试页'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/appBarTest');
                    },
                    child: Text('appBar练习'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/tabBarTest');
                    },
                    child: Text('tabBarController练习'),
                  )
                ]),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: UserAccountsDrawerHeader(
                    accountEmail: Text('12323@qq.com'),
                    accountName: Text('金金老师'),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage('https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20200509%2F4dad705599a54a9ebc88d3baad17ce60.jpeg&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1648021785&t=8ed610f5e7de3c0903a1e55329d42536'),
                    ),
                  ),
                  // child: DrawerHeader(
                  //   child: Text('你好flutter'),
                  //   decoration: BoxDecoration(
                  //     // color: Colors.red,
                  //     image: DecorationImage(
                  //       fit: BoxFit.cover,
                  //       image: NetworkImage('https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20200509%2F4dad705599a54a9ebc88d3baad17ce60.jpeg&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1648021785&t=8ed610f5e7de3c0903a1e55329d42536')
                  //     )
                  //   ),
                  // ),
                )
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('第一个元素'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('第二个元素'),
                ),
                ListTile(
                  leading: Icon(Icons.fourteen_mp),
                  title: Text('第三个元素'),
                ),
              ],
            )
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Text('右侧侧边栏'),
      ),
    );
  }
}