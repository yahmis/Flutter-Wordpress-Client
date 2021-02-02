import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart' as provider;

<<<<<<< HEAD
=======
import '../wordpress_client.dart';
import 'config.dart';
import 'pages/listView.dart';
import 'view_models/app_key.dart';
import 'widgets/drawerMain.dart';

>>>>>>> 3c3dde5b52e0fea4ebd6ae4bc37e62c7ea33cb0a
WordpressClient client = new WordpressClient(_baseUrl, http.Client());
final String _baseUrl = mainApiUrl;

class HawalnirHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HawalnirHomeState();
}

class HawalnirHomeState extends State<HawalnirHome>
    with TickerProviderStateMixin {
  var scrollCont =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: provider.Provider.of<Keys>(context, listen: false).appScaffoldKey,
        drawer: DrawerMain(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomPadding: true,
        body: OfflineBuilder(
            debounceDuration: Duration(seconds: 3),
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              return new Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: FutureBuilder<List<Post>>(
                      future: client.listPosts(page: 3, perPage: 4),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        return snapshot.hasData
                            ? ListViewPosts(posts: snapshot.data)
                            : Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Positioned(
                    height: 24.0,
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      color: connected ? null : Color(0xFFEE4400),
                      child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text("${connected ? '' : 'OFFLINE'}",
                              textDirection: TextDirection.rtl)),
                    ),
                  ),
//                  Positioned(
//                    bottom: 0,
//                    left: 0,
//                    right: 0,
//                    child: Container(
//                      color: Colors.deepPurple.withOpacity(0.8),
//                      child: bottomNavAppBar(),
//                    ),
//                  ),
                ],
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'There are no bottons to push :)',
                ),
                new Text(
                  'Just turn off your internet.',
                ),
              ],
            )));
  }

  bottomNavAppBar() {
    return ClipRect(
      child: Container(
        height: 80,
        child: Stack(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  items: [
                    BottomNavigationBarItem(
                        title: Text('Home'), icon: Icon(Icons.home)),
                    BottomNavigationBarItem(
                        title: Text('Favorites'), icon: Icon(Icons.favorite)),
                    BottomNavigationBarItem(
                        title: Text('gallery'), icon: Icon(Icons.image)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
