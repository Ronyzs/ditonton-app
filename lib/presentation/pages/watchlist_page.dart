import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tvseries_page.dart';

import 'package:flutter/material.dart';

import '../widgets/watchlist_card.dart';

class ListWatchlistPage extends StatelessWidget {
  static const ROUTE_NAME = '/list_watchlist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
              child: WatchListCard(
                icon: Icons.movie,
                title: "Watchlist Movies",
              ),
            ),
            SizedBox(
              height: 22,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvSeriesPage.ROUTE_NAME);
              },
              child: WatchListCard(
                icon: Icons.tv,
                title: "Watchlist TV Series",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
