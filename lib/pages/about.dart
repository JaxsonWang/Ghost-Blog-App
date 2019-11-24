import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import '../widgets/drawer.dart';

class AboutPage extends StatelessWidget {

  static final String route = '/about';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("关于博客"),
      ),
      drawer: buildDrawer(context, AboutPage.route),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0,),
            child: Text("永远年轻，永远热泪盈眶！"),
          ),

          Padding(
            padding: EdgeInsets.all(16.0,),
            child: Text("该页面暂未写完！"),
          ),

          Padding(
            padding: EdgeInsets.all(16.0,),
            child: Text("本站地址：https://iiong.com"),
          ),

          Padding(
            padding: EdgeInsets.all(16.0,),
            child: FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  String version = snapshot.data.version;
                  String buildNumber = snapshot.data.buildNumber;
                  return Text("软件版本为 $version:$buildNumber");
                }

                return Container();
              },
            )
          ),
        ],
      ),
    );
  }
}
