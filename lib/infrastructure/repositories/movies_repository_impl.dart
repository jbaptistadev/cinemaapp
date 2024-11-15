import 'package:cinemaapp/domain/datasources/movies_datasource.dart';
import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDataSource datasource;

  MoviesRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}
