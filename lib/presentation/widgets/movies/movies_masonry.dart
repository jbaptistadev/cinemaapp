import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/presentation/widgets/movies/movie_poster_link.dart';

class MoviesMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MoviesMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MoviesMasonry> createState() => _MoviesMasonryState();
}

class _MoviesMasonryState extends State<MoviesMasonry> {
  bool isMounted = true;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(
      () {
        if (widget.loadNextPage == null) return;

        if ((scrollController.position.pixels + 100) >=
            scrollController.position.maxScrollExtent) {
          widget.loadNextPage!();
        }
      },
    );
  }

  @override
  void dispose() {
    isMounted = false;
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                MoviePosterLink(movie: widget.movies[index])
              ],
            );
          }

          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
