import 'package:duqin_app/models/UserModel.dart';

class VideoList {
  final List<VideoItem> list;

  VideoList(this.list);

  factory VideoList.fromJson(List<dynamic> list) {
    return VideoList(list.map((item) => VideoItem.fromJson(item)).toList());
  }
}

class VideoItem {
  final int id;
  final int userId;
  final String coverPictureUrl;
  final String videoUrl;
  final String title;
  final String intro;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final int shareCount;
  final int contentSeconds;
  final UserItem userInfo;

  VideoItem({
    required this.id,
    required this.userId,
    required this.coverPictureUrl,
    required this.videoUrl,
    required this.title,
    required this.intro,
    required this.commentCount,
    required this.thumbUpCount,
    required this.readCount,
    required this.shareCount,
    required this.contentSeconds,
    required this.userInfo,
  });

  factory VideoItem.fromJson(dynamic item) {
    return VideoItem(
        id: item['id'],
        userId: item['userId'],
        coverPictureUrl: item['coverPictureUrl'],
        videoUrl: item['videoUrl'],
        title: item['title'],
        intro: item['intro'],
        commentCount: item['commentCount'],
        thumbUpCount: item['thumbUpCount'],
        readCount: item['readCount'],
        shareCount: item['shareCount'],
        contentSeconds: item['contentSeconds'],
        userInfo: UserItem.fromJson(item['userInfo'])
    );
  }
}
