import 'package:go_router/go_router.dart';
import 'package:cinemaapp/presentation/screens/screens.dart';
import 'package:cinemaapp/presentation/views/views.dart';

final appRouter = GoRouter(routes: [
  ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) => const HomeView(),
            routes: [
              GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) {
                    final movieId = state.pathParameters['id'] ?? 'no-id';

                    return MovieScreen(
                      movieId: movieId,
                    );
                  })
            ]),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesView(),
        )
      ])
]);
