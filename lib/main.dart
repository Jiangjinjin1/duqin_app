
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:duqin_app/utils/ColorUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'routes/Routes.dart';

void main() {
  runApp(MyApp());

  if (Platform.isAndroid) {
    // 沉浸式状态栏
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

      /// 这是设置状态栏的图标和字体的颜色
      /// Brightness.light  一般都是显示为白色
      /// Brightness.dark 一般都是显示为黑色
      statusBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ThemeData _themeData = ThemeData(
    primaryColor: ColorUtil.primary, // 主题色
    scaffoldBackgroundColor: ColorUtil.page, // 脚手架下的页面背景色
    indicatorColor: ColorUtil.active, // 选项卡栏中所选选项卡指示器的颜色。
    // ElevatedButton 主题
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        // 文字颜色
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.white;
          } else {
            return null;
          }
        }),
        // 背景色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorUtil.danger.withOpacity(0.5);
          } else {
            return ColorUtil.danger;
          }
        }),
      ),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.white.withOpacity(0.5),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: ColorUtil.unactive,
      ),
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: ColorUtil.unactive,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontSize: 18,
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 12),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorUtil.nav,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorUtil.nav,
      selectedItemColor: ColorUtil.active,
      unselectedItemColor: ColorUtil.unactive,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '读琴app',
      theme: _themeData,
      initialRoute: '/transition',
      onGenerateRoute: onGenerateRoute,
    );
  }
}

