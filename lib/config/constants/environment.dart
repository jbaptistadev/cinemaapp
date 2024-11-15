import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String theMovieDbKey =
      dotenv.env['MOVIE_DB_KEY'] ?? "the api key in't defined";
  static final String theMovieApiUrl =
      dotenv.env['MOVIE_API_BASE_URL'] ?? "the api url in't defined";
}
