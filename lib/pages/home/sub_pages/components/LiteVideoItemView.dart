import 'package:duqin_app/components/CommentLikeRead.dart';
import 'package:duqin_app/models/VideoModel.dart';
import 'package:duqin_app/pages/home/sub_pages/components/AvatarRoleName.dart';
import 'package:duqin_app/utils/UtilExt.dart';
import 'package:flutter/material.dart';

class LiteVideoItemView extends StatelessWidget {
  final int index;
  final VideoItem videoItem;

  const LiteVideoItemView(
      {Key? key, required this.index, required this.videoItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isEven = index.isEven;
    final double _pr = _isEven ? 10 : 20;
    final double _pl = _isEven ? 20 : 10;
    return Container(
      padding: EdgeInsets.only(top: 20, left: _pl, right: _pr),
      color: Colors.white,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 312 / 560,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/common/lazy-3.png',
                    image: networkImageToDefault(videoItem.coverPictureUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/icons/tiny_video.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AvatarRoleName(
              headIconUrl: videoItem.userInfo.coverPictureUrl,
              username: videoItem.userInfo.nickname,
              userType: videoItem.userInfo.type,
            ),
          ),
          CommentLikeRead(
            commentCount: videoItem.commentCount,
            thumbUpCount: videoItem.thumbUpCount,
            readCount: videoItem.readCount,
          ),
        ],
      ),
    );
  }
}
