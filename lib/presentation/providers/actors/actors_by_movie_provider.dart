import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemaapp/presentation/providers/actors/actors_repository_provider.dart';
import 'package:cinemaapp/domain/entities/actor.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorMapNotifier, Map<String, List<Actor>>>(
  (ref) {
    final getActors = ref.watch(actorsRepositoryProvider).getActorsByMovie;

    return ActorMapNotifier(getActors: getActors);
  },
);

typedef GetActorsCallBack = Future<List<Actor>> Function(String movieId);

class ActorMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallBack getActors;
  ActorMapNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) {
      return;
    }

    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
