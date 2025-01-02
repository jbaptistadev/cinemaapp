import 'package:cinemaapp/presentation/providers/providers.dart';
import 'package:cinemaapp/presentation/screens/screens.dart';
import 'package:cinemaapp/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    // ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);
    // final popularMovies = ref.watch(popularMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (context, index) {
            return Column(
              children: [
                MoviesSlideShow(movies: moviesSlideShow),
                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),
                // MovieHorizontalListView(
                //   movies: popularMovies,
                //   title: 'Popular movies',
                //   subTitle: 'Lunes 21',
                //   loadNextPage: () =>
                //       ref.read(popularMoviesProvider.notifier).loadNextPage(),
                // ),
                MovieHorizontalListView(
                  movies: upComingMovies,
                  title: 'UpComing movies',
                  subTitle: 'Lunes 21',
                  loadNextPage: () =>
                      ref.read(upComingMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListView(
                  movies: topRatedMovies,
                  title: 'Top Rated movies',
                  subTitle: 'Lunes 21',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          },
        ))
      ],
    );
  }
}
