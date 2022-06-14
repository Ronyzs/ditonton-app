import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_search/series_search_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/tvseries-search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SeriesSearchBloc>().add(QuerySeriesChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SeriesSearchBloc, SeriesSearchState>(
              builder: (context, state) {
                if (state is SeriesSearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SeriesSearchHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final series = result[index];
                        return TvSeriesCard(series);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SeriesSearchError) {
                  return Text(state.msg);
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
