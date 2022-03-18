import 'package:duqin_app/api/Services.dart';
import 'package:duqin_app/components/PageFeedBack.dart';
import 'package:duqin_app/const/constEnum.dart';
import 'package:duqin_app/models/UserModel.dart';
import 'package:duqin_app/pages/home/sub_pages/components/UserItemView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SongerSubPage extends StatefulWidget {
  const SongerSubPage({Key? key}) : super(key: key);

  @override
  _SongerSubPageState createState() => _SongerSubPageState();
}

class _SongerSubPageState extends State<SongerSubPage> with AutomaticKeepAliveClientMixin {

  // 下拉刷新控制器
  EasyRefreshController _easyRefreshController = EasyRefreshController();
  // 独立的滚动视图 防止tab切换时触发下拉刷新 混入AutomaticKeepAliveClientMixin 重写wantKeepAlive方法
  ScrollController _scrollController = ScrollController();

  List<UserItem> _userList = UserList([]).list;
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
    _easyRefreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // 获取歌曲列表数据
  _getUserList() async{
    try {
      Map<String, dynamic> result = await Services.getUserList(page: page, pageSize: pageSize, type: userTypeEnum['DQ_SINGER']['code']);
      UserList UserListModel = UserList.fromJson(result['data']);

      setState(() {
        hasMore = result['curPage'] < result['pages'];
        print('${result['curPage']}---${result['pages']}');
        if (page == 1) {
          _userList = UserListModel.list;
        } else {
          _userList.addAll(UserListModel.list);
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
    await _getUserList();
    // 恢复刷新状态 使onLoad再次可用
    _easyRefreshController.resetLoadState();
  }

  // 加载回调(null为不开启加载)
  Future _onLoad() async {
    if (hasMore) {
      await _getUserList();
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
        empty: _userList.isEmpty,
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
        padding: EdgeInsets.only(top: 5),
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 8,
          mainAxisExtent: MediaQuery.of(context).size.width / 1.55,
        ),
        itemBuilder: (context, index) {
          return UserItemView(
            index: index,
            itemInfo: _userList[index],
          );
        },
      itemCount: _userList.length,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
