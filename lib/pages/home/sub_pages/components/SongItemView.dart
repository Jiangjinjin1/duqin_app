import 'package:duqin_app/models/SongModel.dart';
import 'package:duqin_app/utils/ColorUtil.dart';
import 'package:duqin_app/utils/UtilExt.dart';
import 'package:flutter/material.dart';

class SongItemView extends StatelessWidget {
  SongItem itemInfo;

  SongItemView({
    Key? key,
    required this.itemInfo,
  }) : super(key: key);

  Widget _songCover() {
    return Container(
      width: 75,
      height: 75,
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/common/lazy-1.png',
                  image: itemInfo.coverPictureUrl),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/icons/tiny_video.png',
              width: 22,
              height: 22,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _songInfoView() {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(itemInfo.cnName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: ColorUtil.active,
              )),
          Text(itemInfo.enName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: ColorUtil.unactive,
              )),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Row(
              children: [
                ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/common/lazy-1.png',
                      image: itemInfo.userInfo.coverPictureUrl,
                      width: 25,
                      height: 25,
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Text(
                    itemInfo.userInfo.nickname,
                    style: TextStyle(fontSize: 12, color: ColorUtil.unactive),
                  ),
                ),
                _iconItem('assets/images/icons/comment.png', itemInfo.commentCount),
                _iconItem('assets/images/icons/like.png', itemInfo.thumbUpCount),
                _iconItem('assets/images/icons/read.png', itemInfo.readCount),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _iconItem(String icon, int count) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 18,
            height: 18,
          ),
          SizedBox(width: 2),
          Expanded(
            flex: 1,
            child: Text(
              formatCharCount(count),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: ColorUtil.un3active,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        children: [_songCover(), _songInfoView()],
      ),
    );
  }
}
