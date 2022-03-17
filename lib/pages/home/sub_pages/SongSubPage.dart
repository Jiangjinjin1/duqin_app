import 'package:duqin_app/api/Services.dart';
import 'package:duqin_app/components/PageFeedBack.dart';
import 'package:duqin_app/models/SongModel.dart';
import 'package:duqin_app/pages/home/sub_pages/components/SongItemView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SongSubPage extends StatefulWidget {
  const SongSubPage({Key? key}) : super(key: key);

  @override
  _SongSubPageState createState() => _SongSubPageState();
}

class _SongSubPageState extends State<SongSubPage> with AutomaticKeepAliveClientMixin {
  EasyRefreshController _easyRefreshController = EasyRefreshController();
  ScrollController _scrollController = ScrollController();

  List<SongItem> _songList = SongList([]).list;
  int page = 1;
  int pageSize = 20;
  bool hasMore = true;
  bool loading = true;
  bool error = false;
  String errorMsg = '';


  @override
  void initState() {
    super.initState();
    // _getSongList();
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // 获取歌曲列表数据
  _getSongList() async{
    try {
      Map<String, dynamic> result = await Services.getSongList(page: page, pageSize: pageSize);
      SongList songListModel = SongList.fromJson(result['data']);

      setState(() {
        hasMore = result['curPage'] < result['pages'];
        print('${result['curPage']}---${result['pages']}');
        if (page == 1) {
          _songList = songListModel.list;
        } else {
          _songList.addAll(songListModel.list);
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

  // 刷新回调(null为不开启刷新)
  Future _onRefresh() async {
    if (error) {
      setState(() => error = false);
    }
    page = 1;
    await _getSongList();
    // 恢复刷新状态 使onLoad再次可用
    _easyRefreshController.resetLoadState();
  }

  // 加载回调(null为不开启加载)
  Future _onLoad() async {
    if (hasMore) {
      await _getSongList();
    }
    // 结束加载
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
        empty: _songList.isEmpty,
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
    return ListView.builder(
        controller: _scrollController,
        itemCount: _songList.length,
        itemBuilder: (BuildContext context, int index) {
          return SongItemView(
            itemInfo: _songList[index],
          );
        }
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
