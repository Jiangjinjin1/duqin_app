import 'package:duqin_app/api/Services.dart';
import 'package:duqin_app/components/PageFeedBack.dart';
import 'package:duqin_app/models/VideoModel.dart';
import 'package:duqin_app/pages/home/sub_pages/components/TinyVideoView.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  late PageController _pageController;

  List<VideoItem> _videoList = VideoList([]).list;
  int page = 1;
  int pageSize = 3;
  bool hasMore = true;
  bool loading = true;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: false);
    //设置pageView 滑动监听
    // _pageController.addListener(() {
    //   if (_pageController.position.pixels == _pageController.position.maxScrollExtent) {
    //     print('滑动到了最底部');
    //     _getVideoList();
    //   }
    // });
    _getVideoList();
  }

  Future _getVideoList() async {
    setState(() {
      loading = true;
    });
    try {
      Map<String, dynamic> result =
          await Services.getVideoList(page: page, pageSize: pageSize);
      List<VideoItem> videoModelList = VideoList.fromJson(result['data']).list;

      setState(() {
        hasMore = result['curPage'] < result['pages'];
        if (page == 1) {
          _videoList = videoModelList;
        } else {
          _videoList.addAll(videoModelList);
        }
        page++;
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMsg = e.toString();
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  // 上拉加载更多
  _onPageChanged(int index) {
    if (_videoList.length - 1 == index && hasMore) {
      if (error) {
        setState(() {
          error = false;
        });
      }
      _getVideoList();
    }
  }

  // 下拉刷新
  Future<Null> _onRefresh() async {
    if (error) {
      setState(() {
        error = false;
      });
    }
    page = 1;
    _getVideoList();
  }

  @override
  Widget build(BuildContext context) {
    Widget? _body;
    if (loading) {
      _body = PageFeedBack(firstRefresh: true).build();
    } else if (error) {
      _body = PageFeedBack(
        loading: false,
        error: true,
        errorMsg: errorMsg,
        onErrorTap: () {
          setState(() {
            loading = true;
            error = false;
          });
          _getVideoList();
        },
      ).build();
    } else {
      _body = RefreshIndicator(
        onRefresh: _onRefresh,
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          scrollDirection: Axis.vertical,
          itemCount: _videoList.length,
          itemBuilder: (BuildContext context, int index) {
            return TinyVideoView(tinyVideoItem: _videoList[index]);
          },
        ),
      );
    }
    return Scaffold(
      body: _body,
    );
  }
}
