import 'package:duqin_app/models/VideoModel.dart';
import 'package:duqin_app/pages/home/sub_pages/components/ActionsToolbar.dart';
import 'package:duqin_app/pages/home/sub_pages/components/VideoIntro.dart';
import 'package:duqin_app/utils/UtilExt.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TinyVideoView extends StatefulWidget {
  final VideoItem tinyVideoItem;
  const TinyVideoView({Key? key, required this.tinyVideoItem}) : super(key: key);

  @override
  _TinyVideoViewState createState() => _TinyVideoViewState();
}

class _TinyVideoViewState extends State<TinyVideoView> with SingleTickerProviderStateMixin {
  // 播放器实例
  late VideoPlayerController _videoPlayerController;
  // 播放器初始化的Future
  late Future<void> _initializeVideoPlayerFuture;
  // 动画实例
  late AnimationController _animationController;
  // 缓冲是否结束
  bool isBuffering = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      widget.tinyVideoItem.videoUrl,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    // 动画控制器
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // 播放器循环播放
    _videoPlayerController.setLooping(true);
    // 播放器初始化
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    // 播放器完成初始化
    _initializeVideoPlayerFuture.then((_) {
      setState(() {
        isBuffering = true;
        // 开始播放
        _videoPlayerController.play();
        // 动画执行
        _animationController.forward(from: 0.0);
      });
    });

    // 监听动画状态改变
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 继续执行
        _animationController.forward(from: 0.0);
      }
    });

    _videoPlayerController.addListener(() {
      if (!_videoPlayerController.value.isBuffering && isBuffering) {
        setState(() {
          isBuffering = false;
        });
      }
    });


  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // 播放或暂停
  void _onPlayOrPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        _animationController.stop();
      } else {
        _videoPlayerController.play();
        _animationController.forward(from: _animationController.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _videoPlayer(),
          _playIcon(),
          _loading(),
          Positioned(
            right: toRpx(size: 10),
            bottom: toRpx(size: 20),
            child: ActionsToolbar(
              commentCount: widget.tinyVideoItem.commentCount,
              thumbUpCount: widget.tinyVideoItem.thumbUpCount,
              shareCount: 0,
              thumbUp: true,
              userAvatar: widget.tinyVideoItem.userInfo.coverPictureUrl,
              animationController: _animationController,
            ),
          ),
          Positioned(
            left: toRpx(size: 20),
            right: toRpx(size: 160),
            bottom: toRpx(size: 20),
            child: VideoIntro(
              nickname: widget.tinyVideoItem.userInfo.nickname,
              intro: widget.tinyVideoItem.intro,
            ),
          ),
        ],
      ),
    );
  }

  // 播放器
  Widget _videoPlayer() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // 初始化完 展示播放器
          return Center(
            child: GestureDetector(
              onTap: _onPlayOrPause,
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              ),
            ),
          );
        } else {
          // 则展示封面
          return Image.network(
            networkImageToDefault(widget.tinyVideoItem.coverPictureUrl),
            fit: BoxFit.cover,
          );
        }
      },
    );
  }

  // 播放按钮
  Widget _playIcon() {
    // 初始化完成 并且暂停了 则展示播放按钮
    if (_videoPlayerController.value.isInitialized &&
        !_videoPlayerController.value.isPlaying) {
      return Center(
        child: GestureDetector(
          onTap: _onPlayOrPause,
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/images/icons/play_plus.png',
              width: toRpx(size: 118),
              height: toRpx(size: 118),
            ),
          ),
        ),
      );
    }
    // 则展示空组件
    return const SizedBox.shrink();
  }

  // 缓冲中
  Widget _loading() {
    if (isBuffering) {
      return const Align(
        alignment: Alignment.bottomCenter,
        child: LinearProgressIndicator(),
      );
    }
    // 则展示空组件
    return const SizedBox.shrink();
  }
  
}
