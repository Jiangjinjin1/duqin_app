import 'package:duqin_app/models/UserModel.dart';

class ArticleList {
  final List<ArticleItem> list;

  ArticleList(this.list);

  factory ArticleList.fromJson(List<dynamic> list) {
    return ArticleList(list.map((item) => ArticleItem.fromJson(item)).toList());
  }
}

class ArticleItem {
  final int id;
  final int userId;
  final List<String> coverUrlList;
  final String title;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final UserItem userInfo;

  ArticleItem({
    required this.id,
    required this.userId,
    required this.coverUrlList,
    required this.title,
    required this.commentCount,
    required this.thumbUpCount,
    required this.readCount,
    required this.userInfo,
  });

  factory ArticleItem.fromJson(dynamic item) {
    return ArticleItem(
      id: item['id'],
      userId: item['userId'],
      coverUrlList: item['coverUrlList'],
      title: item['title'],
      commentCount: item['commentCount'],
      thumbUpCount: item['thumbUpCount'],
      readCount: item['readCount'],
      userInfo: UserItem.fromJson(item['userInfo'])
    );
  }
}
