import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_reverpod/util/extension.dart';

import '../../provider/provider.dart';

class MovieTags extends ConsumerWidget {
  const MovieTags({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var movieType = ref.watch(movieTypeProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: MoviesType.values
            .map((type) => GestureDetector(
                  onTap: () => ref.read(movieTypeProvider.notifier).state = type,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 6, left: 6, top: 0, bottom: 10),
                    child: Chip(
                        backgroundColor: type == movieType ? Colors.red.shade900 : Colors.grey.withOpacity(0.1),
                        side: BorderSide(color: type == movieType ? Colors.red.shade400 : Colors.grey.shade800),
                        label: Text(type.name)),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
