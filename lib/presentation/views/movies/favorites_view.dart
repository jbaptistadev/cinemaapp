import 'package:cinemaapp/presentation/widgets/movies/movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemaapp/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              size: 60,
              color: colors.primary,
            ),
            Text(
              'Ohhh! noo',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            Text(
              'You dont have favorite movies added',
              style: TextStyle(fontSize: 20, color: colors.secondary),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonal(
                onPressed: () => context.go('/home/0'),
                child: const Text('Start to find them'))
          ],
        ),
      );
    }

    return Scaffold(
      body: MoviesMasonry(
        loadNextPage: loadNextPage,
        movies: favoriteMovies,
      ),
    );
  }
}
