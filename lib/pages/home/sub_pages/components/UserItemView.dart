import 'package:duqin_app/models/UserModel.dart';
import 'package:duqin_app/utils/ColorUtil.dart';
import 'package:flutter/material.dart';

class UserItemView extends StatelessWidget {
  final UserItem itemInfo;
  final int index;
  const UserItemView({Key? key, required this.itemInfo, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isEven = index.isEven;
    final double _pr = _isEven ? 10 : 20;
    final double _pl = _isEven ? 20 : 10;
    return Container(
      padding: EdgeInsets.only(left: _pl, right: _pr, top: 20),
      color: Colors.white,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/common/lazy-1.png',
                image: itemInfo.coverPictureUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              itemInfo.nickname,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: ColorUtil.active,
              ),
            ),
          ),
          Row(
            children: [
              _iconItem('assets/images/icons/read.png', '歌曲', itemInfo.musicCount),
              _iconItem('assets/images/icons/read.png', '播放', itemInfo.musicPlayCount),
            ],
          )
        ],
      ),
    );
  }

  Widget _iconItem(String icon, String label, int count) {
    return Expanded(
      flex: 1,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 2),
              child: Image.asset(icon, width: 18, height: 18, fit: BoxFit.cover),
            ),
            Expanded(
              flex: 1,
                child: Text(
                  '${label}:${count}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorUtil.un3active,
                  ),
                )
            )
          ],
        )
    );
  }

}
