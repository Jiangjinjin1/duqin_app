import 'package:duqin_app/api/Services.dart';
import 'package:duqin_app/models/SongModel.dart';
import 'package:flutter/material.dart';

class SongerSubPage extends StatefulWidget {
  const SongerSubPage({Key? key}) : super(key: key);

  @override
  _SongerSubPageState createState() => _SongerSubPageState();
}

class _SongerSubPageState extends State<SongerSubPage> {

  List<SongItem> _songList = SongList([]).list;
  int page = 1;
  int pageSize = 20;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();

    _getSongList();
  }

  // 获取歌曲列表数据
  _getSongList() async{
    Map<String, dynamic> result = await Services.getSongList(page: page, pageSize: pageSize);
    SongList songListModel = SongList.fromJson(result['data']);

    setState(() {
      hasMore = result['curPage'] < result['pages'];
      page++;

      if (page == 1) {
        _songList.addAll(songListModel.list);
      } else {
        _songList = songListModel.list;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _songList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_songList[index].cnName),
          );
        }
      );
  }
}
