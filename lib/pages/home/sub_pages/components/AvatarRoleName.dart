import 'package:duqin_app/const/constEnum.dart';
import 'package:duqin_app/utils/ColorUtil.dart';
import 'package:duqin_app/utils/UtilExt.dart';
import 'package:flutter/material.dart';

// 头像角色昵称
class AvatarRoleName extends StatelessWidget {
  final String headIconUrl;
  final String? username;
  final String userType;
  final bool showType;
  final double avatarSize;

  const AvatarRoleName({
    Key? key,
    required this.headIconUrl,
    required this.userType,
    required this.username,
    this.showType = true,
    this.avatarSize = 25.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      _avatar(),
      _username(),
    ];
    if (showType) {
      _list.insert(1, _role());
    }
    return Row(
      children: _list,
    );
  }

  // 头像
  Widget _avatar() {
    return Container(
      width: avatarSize,
      height: avatarSize,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: ColorUtil.page,
        borderRadius: BorderRadius.circular(avatarSize),
      ),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/common/lazy-1.png',
          image: networkImageToDefault(headIconUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 角色
  Widget _role() {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: UserType.formColor(userType),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        UserType.formCn(userType),
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }

  // 昵称
  Widget _username() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(left: 4),
        child: Text(
          username ?? '读琴用户',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            color: ColorUtil.unactive,
          ),
        ),
      ),
    );
  }
}
