import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemaapp/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemaapp/infrastructure/repositories/movies_repository_impl.dart';

// this repository is immutable, his objective is allows to all of providers access to all the information provide for dataSource
final moviesRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(MovieDbDataSource());
});
