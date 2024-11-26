import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>(
  (ref) {
    final getMovieById = ref.watch(moviesRepositoryProvider).getMovieById;

    return MovieMapNotifier(getMovie: getMovieById);
  },
);

typedef GetMovieCallBack = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) {
      return;
    }

    final Movie movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
