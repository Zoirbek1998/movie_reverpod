import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_reverpod/model/movie/movie.dart';
import 'package:movie_reverpod/pages/widget/cast_list.dart';
import 'package:movie_reverpod/pages/widget/my_sliver_app_bar.dart';
import 'package:movie_reverpod/pages/widget/recommended_widget.dart';
import 'package:rich_text_view/rich_text_view.dart';
import 'package:skeletons/skeletons.dart';

import '../model/MovieDetails/MovieDetails.dart';
import '../provider/provider.dart';

class MovieDetailsPage extends ConsumerWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetails = ref.watch(movieDetailsProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: MySliverAppBar(
            movie: movie,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
          )),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  movieDetails.maybeWhen(
                    orElse: () => const Center(child: Text('Or Lese')),
                    loading: () => _movieDetailsShimmer(context),
                    data: (data) => _buildMovieDetailsContent(context, data),
                  ),
                  const SizedBox(height: 16),
                  Text('Top Bill Cost', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10,),
                  const CastList(),
                  const SizedBox(height: 10,),
                  Text('Recommended', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16,),
                 const RecommendedWidget(),
                ],
              ),
            )
          ])),
        ],
      ),
    );
  }
  _buildMovieDetailsContent(BuildContext context, MovieDetails movie) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(movie.adult ? "-18" : "18+", style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
            Row(
              children: [
                const Icon(IconlyLight.star, size: 18, color: Colors.yellow,),
                const SizedBox(width: 5,),
                Text(movie.vote_average.toString(), style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
              ],
            ),
            const SizedBox(width: 160,),
            InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                onTap: (){},
                child: const Icon(Icons.share)
            ),
            InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                onTap: (){},
                child: const Icon(Icons.bookmark_outline)
            ),
          ],
        ),
        const SizedBox(height: 16,),
        Text(movie.tagline, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.grey.shade400, fontSize: 12),),
        const SizedBox(height: 16,),
        Text('Overview', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12,),
        RichTextView(
          text: movie.overview,
          maxLines: 4,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.5, color: Colors.grey.shade200),
          truncate: true,
          viewLessText: 'less',
          linkStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.red.shade900),
          supportedTypes:  [
            EmailParser(
                onTap: (email) => print('${email.value} clicked')),
            PhoneParser(
                onTap: (phone) => print('click phone ${phone.value}')),
            MentionParser(
                onTap: (mention) => print('${mention.value} clicked')),
            UrlParser(onTap: (url) => print('visting ${url.value}?')),
            BoldParser(),
            HashTagParser(
                onTap: (hashtag) =>
                    print('is ${hashtag.value} trending?'))
          ],
        ),
      ],
    );
  }

  _movieDetailsShimmer(BuildContext context){
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 30,
                      width: 40,
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsetsDirectional.only(start: 5)
                  ),
                ),
                const SizedBox(width:20,),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 30,
                      width: 40,
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsetsDirectional.only(start: 5)
                  ),
                ),
              ],
            ),
            const SizedBox(width: 150,),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  height: 30,
                  width: 40,
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsetsDirectional.only(start: 5)
              ),
            ),
            const SizedBox(width:20,),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  height: 30,
                  width: 40,
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsetsDirectional.only(start: 5)
              ),
            ),
          ],
        ),
        const SizedBox(height: 16,),
        const SkeletonLine(
          style: SkeletonLineStyle(
              height: 10,
              width: 200
          ),
        ),
        const SizedBox(height: 16,),
        Text('Overview', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12,),
        SkeletonParagraph(
          style: const SkeletonParagraphStyle(
            lines: 4,
            spacing: 8,
            padding: EdgeInsets.all(0),
            lineStyle: SkeletonLineStyle(
              alignment: Alignment.topLeft,
              height: 12,
              randomLength: true,
            ),
          ),
        ),
      ],
    );
  }
}


