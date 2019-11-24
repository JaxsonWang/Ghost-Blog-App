import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/about.dart';
import '../pages/feed.dart';

Widget _buildDrawerHeader(context) {
  return Stack(
    children: <Widget>[
      Container(
        height: 150.0,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage('assets/img/abstract.jpg',),
            fit: BoxFit.cover,
          ),
        ),
      ),

      Container(
        height: 150.0,
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.0),
              Colors.black.withOpacity(0.8),
            ],
            stops: [
              0.6,
              1.0,
            ],
          ),
        ),
        child: Text(
          "淮城一只猫",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 1.0,
                ),
              ]
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(left: 16.0, bottom: 16.0,),
      ),
    ],
  );
}

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return new Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        _buildDrawerHeader(context),

        ListTile(
          leading: Icon(Icons.list),
          title: const Text('博客文章'),
          selected: currentRoute == FeedPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, FeedPage.route);
          },
        ),

        ListTile(
          leading: Icon(Icons.help_outline),
          title: const Text("关于博客"),
          selected: currentRoute == AboutPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, AboutPage.route);
          },
        ),

        ListTile(
          leading: Icon(Icons.mail_outline),
          title: const Text("联系博主"),
          onTap: () async {
            const url = "mailto:i@iiong.com?subject=填写事要标题&body=填写事要内容";
            if (await canLaunch(url)) {
            await launch(url);
            } else {
            throw "无法打开邮箱程序";
            }
          },
        ),
      ],
    ),
  );
}