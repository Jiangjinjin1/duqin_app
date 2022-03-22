import 'package:duqin_app/utils/ColorUtil.dart';
import 'package:duqin_app/utils/UtilExt.dart';
import 'package:flutter/material.dart';

// 评论点赞查看
class CommentLikeRead extends StatelessWidget {
  final int commentCount;
  final int thumbUpCount;
  final int readCount;

  const CommentLikeRead({
    Key? key,
    this.commentCount = 0,
    this.readCount = 0,
    this.thumbUpCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _iconItem('assets/images/icons/comment.png', commentCount),
        _iconItem('assets/images/icons/like.png', thumbUpCount),
        _iconItem('assets/images/icons/read.png', readCount),
      ],
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
          const SizedBox(width: 2),
          Expanded(
            flex: 1,
            child: Text(
              formatCharCount(count),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: ColorUtil.un3active,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
