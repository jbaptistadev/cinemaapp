import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String theMovieDbKey =
      dotenv.env['MOVIE_DB_KEY'] ?? "the api key in't defined";
}
