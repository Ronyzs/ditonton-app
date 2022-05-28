import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';

import '../pages/about_page.dart';
import '../pages/home_movie_page.dart';
import '../pages/home_tvseries_page.dart';
import '../pages/watchlist_movies_page.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('TV Series'),
            onTap: () {
              Navigator.pushNamed(context, HomeTvSeriesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, ListWatchlistPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
