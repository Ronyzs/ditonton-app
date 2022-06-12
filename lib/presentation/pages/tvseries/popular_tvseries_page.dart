import 'package:ditonton/presentation/bloc/tvseries/tvseries_popular/series_popular_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<SeriesPopularBloc>().add(FetchPopularSeriesList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeriesPopularBloc, SeriesPopularState>(
          builder: (context, state) {
            if (state is SeriesPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeriesPopularHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = result[index];
                  return TvSeriesCard(series);
                },
                itemCount: result.length,
              );
            } else if (state is SeriesPopularError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.msg),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
