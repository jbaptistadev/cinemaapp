import 'package:cinemaapp/domain/entities/actor.dart';
import 'package:cinemaapp/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'not-profile-image',
      character: cast.character);
}
