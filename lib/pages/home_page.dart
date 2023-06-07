import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_reverpod/pages/widget/movie_list.dart';
import 'package:movie_reverpod/pages/widget/movie_tags.dart';
import 'package:movie_reverpod/pages/widget/upcoming_shimmer.dart';

import '../provider/provider.dart';
import '../util/env_config.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    final moviesAsyncValue = ref.watch(upcomingProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
        leading: const Icon(IconlyLight.category),
        actions: const [
          Icon(IconlyLight.notification),
          SizedBox(width: 20),
          Icon(IconlyLight.search),
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// searchBar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search movies, series...',
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        isDense: true,
                        prefixIcon: const Icon(IconlyLight.search),
                      ),
                      style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade400),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.shade900,
                    ),
                    child: IconButton(
                      icon: const Icon(IconlyLight.filter),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            /// Card
            moviesAsyncValue.maybeWhen(
                orElse: () => const Center(child: Text('Malumot mavjud emas')),
                loading: () => const UpcomingShimmer(),
                data: (movies) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (ctx, index) {
                            final movie = movies[index];
                            return Container(
                              width: MediaQuery.of(context).size.height * 0.43,
                              margin: const EdgeInsets.only(right: 15),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        EnvironmentConfig.IMAGE_BASE_URL_COVER +
                                            movie.backdrop_path!),
                                    fit: BoxFit.fill),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 1,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                    // color: Colors.black.withOpacity(0.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              flex: 3,
                                              child: Text(
                                                movie.title,
                                                style: theme
                                                    .textTheme.titleMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                IconlyLight.star,
                                                size: 18,
                                                color: Colors.yellow,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                movie.vote_average.toString(),
                                                style: theme
                                                    .textTheme.titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red.shade900,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          IconlyLight.play,
                                          size: 40,
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    )),

            /// category menu
            const MovieTags(),
            const SizedBox(
              height: 20,
            ),
            /// Menu items
           const MovieList()
          ],
        ),
      ),
    );
  }
}
