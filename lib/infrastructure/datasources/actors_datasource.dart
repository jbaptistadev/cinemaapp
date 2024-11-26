import 'package:cinemaapp/config/constants/environment.dart';
import 'package:cinemaapp/domain/datasources/actors_datasource.dart';
import 'package:cinemaapp/domain/entities/actor.dart';
import 'package:cinemaapp/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemaapp/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorsMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.theMovieApiUrl,
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
