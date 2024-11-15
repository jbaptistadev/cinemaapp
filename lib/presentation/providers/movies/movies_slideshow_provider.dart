import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemaapp/presentation/providers/providers.dart';
import 'package:cinemaapp/domain/entities/movie.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0, 8);
});
