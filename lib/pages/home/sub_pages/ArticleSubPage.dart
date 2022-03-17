import 'package:flutter/material.dart';

class ArticleSubPage extends StatefulWidget {
  const ArticleSubPage({Key? key}) : super(key: key);

  @override
  _ArticleSubPageState createState() => _ArticleSubPageState();
}

class _ArticleSubPageState extends State<ArticleSubPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('文章'),
    );
  }
}
