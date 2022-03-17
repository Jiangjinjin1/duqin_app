import 'package:duqin_app/models/UserModel.dart';

class SongList {
  final List<SongItem> list;

  SongList(this.list);

  factory SongList.fromJson(List<dynamic> list) {
    return SongList(list.map((item) => SongItem.fromJson(item)).toList());
  }
}

class SongItem {
  final int id;
  final int userId;
  final String coverPictureUrl;
  final String songUrl;
  final String cnName;
  final String enName;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final UserItem userInfo;

  SongItem({
    required this.id,
    required this.userId,
    required this.coverPictureUrl,
    required this.songUrl,
    required this.cnName,
    required this.enName,
    required this.commentCount,
    required this.thumbUpCount,
    required this.readCount,
    required this.userInfo,
  });

  factory SongItem.fromJson(dynamic item) {
    return SongItem(
        id: item['id'],
        userId: item['userId'],
        coverPictureUrl: item['coverPictureUrl'],
        songUrl: item['songUrl'],
        cnName: item['cnName'],
        enName: item['enName'],
        commentCount: item['commentCount'],
        thumbUpCount: item['thumbUpCount'],
        readCount: item['readCount'],
        userInfo: UserItem.fromJson(item['userInfo']));
  }
}
