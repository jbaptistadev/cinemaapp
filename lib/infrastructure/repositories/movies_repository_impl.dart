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

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated();
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return datasource.getUpComing();
  }
}
