import 'package:duqin_app/api/Services.dart';
import 'package:duqin_app/components/PageFeedBack.dart';
import 'package:duqin_app/models/VideoModel.dart';
import 'package:duqin_app/pages/home/sub_pages/components/LiteVideoItemView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class LitVideoSubPage extends StatefulWidget {
  const LitVideoSubPage({Key? key}) : super(key: key);

  @override
  _LitVideoSubPageState createState() => _LitVideoSubPageState();
}

class _LitVideoSubPageState extends State<LitVideoSubPage> with AutomaticKeepAliveClientMixin {
  EasyRefreshController _easyRefreshController = EasyRefreshController();
  ScrollController _scrollController = ScrollController();

  List<VideoItem> _videoList = VideoList([]).list;
  int page = 1;
  int pageSize = 20;
  bool hasMore = true;
  bool loading = true;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _easyRefreshController.dispose();
    _scrollController.dispose();
  }

  Future _getVideoList() async{
    try {
      Map<String, dynamic> result = await Services.getVideoList(page: page, pageSize: pageSize);
      VideoList videoListModel = VideoList.fromJson(result['data']);

      setState(() {
        hasMore = result['curPage'] < result['pages'];
        if (page == 1) {
          _videoList = videoListModel.list;
        } else {
          _videoList.addAll(videoListModel.list);
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

  Future _onRefresh() async {
    if (error) {
      setState(() {
        error = false;
      });
    }
    page = 1;
    await _getVideoList();
    _easyRefreshController.resetLoadState();

  }

  Future _onLoad() async {
    if (hasMore) {
      await _getVideoList();
    }
    _easyRefreshController.finishLoad(noMore: !hasMore);
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      firstRefresh: true,
      firstRefreshWidget: PageFeedBack(firstRefresh: true).build(),
      emptyWidget: PageFeedBack(
        loading: loading,
        error: error,
        empty: _videoList.isEmpty,
        errorMsg: errorMsg,
        onErrorTap: () => _easyRefreshController.callRefresh(),
        onEmptyTap: () => _easyRefreshController.callRefresh(),
      ).build(),
      controller: _easyRefreshController,
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      onRefresh:_onRefresh,
      onLoad: _onLoad,
      child: _listView(),
    );
  }

  Widget _listView() {
    return GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return LiteVideoItemView(
            index: index,
            videoItem: _videoList[index],
          );
        },
      itemCount: _videoList.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
