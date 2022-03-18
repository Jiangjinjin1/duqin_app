import 'package:duqin_app/http/Http.dart';

class Services {
  // 推荐接口

  static Future getSongList({int? page = 1, int? pageSize = 20 }) async {
    const String path = '/api/song/getSongList';
    final response = await Http.post(
      path,
      data: {'pageSize': pageSize, 'page': page},
    );
    Map<String, dynamic> result = response['data'];
    return result;
  }

  // 歌手数据
  static Future getUserList({int? page = 1, int? pageSize = 20, required String type }) async {
    const String path = '/api/user/getUserList';
    final response = await Http.post(
      path,
      data: {'pageSize': pageSize, 'page': page, 'type': type},
    );
    Map<String, dynamic> result = response['data'];
    return result;
  }

}