import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemaapp/config/helpers/human_format.dart';
import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef MoviesSearchCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final MoviesSearchCallBack searchMovies;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isSearching = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate(
      {required this.searchMovies, required this.initialMovies});

  void _onQueryChanged(String query) {
    isSearching.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (query.isEmpty) {
          debounceMovies.add([]);
        }

        final movies = await searchMovies(query);
        initialMovies = movies;
        debounceMovies.add(movies);
        isSearching.add(false);
      },
    );
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return _MovieItem(
              movie: movie,
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  void clearStreams() {
    debounceMovies.close();
  }

  @override
  String get searchFieldLabel => 'movie search';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
          initialData: false,
          stream: isSearching.stream,
          builder: (context, snapshot) {
            return (snapshot.data ?? false)
                ? SpinPerfect(
                    duration: const Duration(seconds: 20),
                    spins: 10,
                    infinite: true,
                    child: IconButton(
                      onPressed: () => query = '',
                      icon: const Icon(Icons.refresh_rounded),
                    ))
                : FadeIn(
                    duration: const Duration(milliseconds: 100),
                    animate: query.isNotEmpty,
                    child: IconButton(
                        onPressed: () => query = '',
                        icon: const Icon(Icons.clear)));
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: (movie.posterPath == 'no-poster')
                    ? Image.asset('assets/images/poster-not-available.jpeg')
                    : Image.network(
                        movie.posterPath,
                        loadingBuilder: (context, child, loadingProgress) =>
                            FadeIn(child: child),
                      ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
