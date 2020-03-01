import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:html/dom.dart' as dom;

import '../utils/ghost_api.dart';

class Post extends StatelessWidget {
  static const String route = '/post';

  final PostPage post;

  Post({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _shareButton(Color color) {
      return IconButton(
        color: color,
        icon: Icon(Icons.share),
        onPressed: () {
          Share.share(post.title + " " + post.url);
        },
      );
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              actions: <Widget>[_shareButton(null)],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  post.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                ),
                centerTitle: false,
                titlePadding: EdgeInsets.symmetric(
                  horizontal: 48.0,
                  vertical: 16.0,
                ),
                background: post.featureImage != null
                    ? Image.network(
                        post.featureImage,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            )
          ];
        },
        body: ListView(
          children: <Widget>[
            Html(
              data: post.html,
              padding: EdgeInsets.all(16.0),
              backgroundColor: Colors.white70,
              defaultTextStyle: TextStyle(height: 1.25, fontFamily: 'inherit'),
              linkStyle: const TextStyle(
                color: Colors.teal,
              ),
              useRichText: false,
              customRender: (node, children) {
                var render;
                if (node is dom.Element) {
                  switch (node.localName) {
                    case 'figure':
                      render = new Text('');
                  }
                }
                return render;
              },
              onLinkTap: (url) async {
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw '无法打开 $url';
                }
              },
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                    post.primaryAuthor.profileImage,
                  ),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(post.primaryAuthor.name),
                subtitle: Text(post.primaryAuthor.bio),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Center(
                child: FlatButton(
                  child: Text("查看源站"),
                  onPressed: () async {
                    final String url = post.url;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw '无法打开 $url';
                    }
                  },
                  padding: EdgeInsets.all(
                    16.0,
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Center(
                child: FlatButton(
                  child: Text("返回"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.all(
                    16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
