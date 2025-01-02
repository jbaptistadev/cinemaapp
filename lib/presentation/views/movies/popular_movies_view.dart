import 'package:cinemaapp/presentation/providers/providers.dart';
import 'package:cinemaapp/presentation/screens/screens.dart';
import 'package:cinemaapp/presentation/widgets/movies/movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({super.key});

  @override
  ConsumerState<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    final movies =
        await ref.read(popularMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final popularMovies = ref.watch(popularMoviesProvider);

    return Scaffold(
      body: MoviesMasonry(
        movies: popularMovies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
