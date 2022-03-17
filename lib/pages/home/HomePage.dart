import 'package:duqin_app/utils/ColorUtil.dart';
import 'package:flutter/material.dart';
import 'IndexPage.dart';
import 'MusicPage.dart';
import 'VideoPage.dart';
import 'MyProfilePage.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class HomePage extends StatefulWidget {
  Map? arguments;
  HomePage({Key? key, this.arguments}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(arguments: arguments);
}

class _HomePageState extends State<HomePage> {
  Map? arguments;
  int _currentIndex = 0;
  //IndexedStackChild 懒加载包裹，底部tab切换时缓存tab状态,不重复请求接口
  final List<IndexedStackChild> _pageList = [
    IndexedStackChild(child: IndexPage()),
    IndexedStackChild(child: MusicPage()),
    IndexedStackChild(child: Text('')),
    IndexedStackChild(child: VideoPage()),
    IndexedStackChild(child: MyProfilePage()),
  ];

  _HomePageState({this.arguments});

  @override
  void initState() {
    super.initState();
    if (arguments != null && arguments!['selectIndex'] >= 0) {
      int selectIndex = arguments!['selectIndex'] >= 0 ? arguments!['selectIndex'] : 0;
      setState(() {
        _currentIndex = selectIndex;
      });
    }

  }

  void _onTap(int index) {
    if (index == 2) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProsteIndexedStack(
        index: _currentIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: _currentIndex,
        // fixedColor: const Color.fromRGBO(153,153,153,1),
        fixedColor: const Color.fromRGBO(255,195,0,1),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: '首页',
            icon: Image.asset('assets/images/icons/home.png', width: 24, height: 24),
            activeIcon: Image.asset('assets/images/icons/home_active.png', width: 24, height: 24)
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.shop),
            label: '音乐',
            icon: Image.asset('assets/images/icons/music.png', width: 24, height: 24),
            activeIcon: Image.asset('assets/images/icons/music_active.png', width: 24, height: 24)
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.flaky),
            label: '',
            icon: Image.asset('assets/images/icons/create_media.png', width: 24, height: 24),
            activeIcon: Image.asset('assets/images/icons/create_media.png', width: 24, height: 24)
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.forward),
            label: '小视频',
            icon: Image.asset('assets/images/icons/tiny_video.png', width: 24, height: 24),
            activeIcon: Image.asset('assets/images/icons/tiny_video_active.png', width: 24, height: 24)
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.thirteen_mp),
            label: '我的',
            icon: Image.asset('assets/images/icons/profile.png', width: 24, height: 24),
            activeIcon: Image.asset('assets/images/icons/profile_active.png', width: 24, height: 24)
          )
        ],
      ),
      floatingActionButton: _createMediaButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _createMediaButton() {
    return Container(
      width: 44,
      height: 44,
      margin: EdgeInsets.only(top: 56),
      child: FloatingActionButton(
        backgroundColor: ColorUtil.nav,
        elevation: 0,
        onPressed: () {
          // todo 待处理

        },
        child: Image.asset(
          'assets/images/icons/create_media.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}