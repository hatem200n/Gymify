import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymfiy/core/errors/error_retry_view.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/home/presentation/screens/filltred_exercises.dart';
import 'package:gymfiy/features/home/presentation/widgets/all-exrciecs-section/all_exercises_list_card.dart';
import 'package:gymfiy/features/search/provider/serach_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchResultsPage extends ConsumerStatefulWidget {
  final FilterArgs filterArgs;
  const SearchResultsPage({super.key, required this.filterArgs});

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels >=
            _controller.position.maxScrollExtent - 300) {
          ref
              .read(searchExercisesProvider(widget.filterArgs).notifier)
              .fetchMore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync =
        ref.watch(searchExercisesProvider(widget.filterArgs));

    return Scaffold(
      appBar: AppBar(title: "Search Results".makeBodyText(context)),
      body: exercisesAsync.when(
        loading: () => _buildSkeleton(),
        error: (e, _) => ErrorRetryView(
          message: e.toString(),
          onRetry: () =>
              ref.invalidate(searchExercisesProvider(widget.filterArgs)),
        ),
        data: (exercises) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(searchExercisesProvider(widget.filterArgs));
            await ref.read(searchExercisesProvider(widget.filterArgs).future);
          },
          child: ListView.builder(
            controller: _controller,
            itemCount: exercises.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final item = exercises[index];
              return AllExercisesListCard(item: item);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return Skeletonizer(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (_, __) => const ExerciseSkeletonCard(),
      ),
    );
  }
}
