import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallBack fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    print('load next page');
    currentPage++;
    if (isLoading) return;
    isLoading = true;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
