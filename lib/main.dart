import 'package:flutter/material.dart';
import 'package:flutter_ghost_content_api/flutter_ghost_content_api.dart';
import './pages/about.dart';
import './pages/feed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GhostContentAPIProvider(
      client: GhostContentAPIClient(
        version: 'v2',
        url: 'https://iiong.com',
        contentAPIKey: '99efee9603c92e5cd04501f069',
      ),
      child: MaterialApp(
        title: '淮城一只猫',
        home: FeedPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        routes: <String, WidgetBuilder>{
          AboutPage.route: (context) => new AboutPage()
        },
      ),
    );
  }
}


