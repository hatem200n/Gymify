import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/errors/error_retry_view.dart';
import 'package:gymfiy/features/home/presentation/widgets/all-exrciecs-section/all_exercises_list.dart';
import 'package:gymfiy/features/home/presentation/widgets/banners-section/home_page_banner.dart';
import 'package:gymfiy/features/home/providers/home_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FilltredExercises extends ConsumerStatefulWidget {
  final String fillterType;
  final String fillterValue;
  final String background;
  const FilltredExercises(
      {super.key,
      required this.fillterType,
      required this.fillterValue,
      required this.background});

  @override
  ConsumerState<FilltredExercises> createState() => _FilltredExercises();
}

class _FilltredExercises extends ConsumerState<FilltredExercises> {
  late final ScrollController _controller;

  FilterArgs get filterArgs =>
      (type: widget.fillterType, value: widget.fillterValue);

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels >=
            _controller.position.maxScrollExtent - 300) {
          ref.read(filteredExercisesProvider(filterArgs).notifier).fetchMore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(filteredExercisesProvider(filterArgs));

    return Scaffold(
      appBar: AppBar(title: Text(widget.fillterValue)),
      body: exercisesAsync.when(
        loading: () => buildExercisesSkeleton(),
        error: (e, _) => ErrorRetryView(
          message: e.toString(),
          onRetry: () {
            ref.invalidate(filteredExercisesProvider(filterArgs));
          },
        ),
        data: (exercises) {
          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(filteredExercisesProvider(filterArgs).notifier)
                  .refresh();
            },
            child: ListView(
              controller: _controller,
              padding: EdgeInsets.symmetric(vertical: 15.r),
              children: [
                Hero(
                  tag: widget.fillterValue,
                  child: HomePageBanner(image: widget.background),
                ),
                AllExercisesList(
                  title: "Results for ${widget.fillterValue}",
                ),
                if (exercisesAsync.isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: ExerciseSkeletonCard(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildExercisesSkeleton() {
    return Skeletonizer(
      child: ListView.builder(
          itemCount: 6,
          padding: EdgeInsets.symmetric(vertical: 15.r),
          itemBuilder: (_, __) => const ExerciseSkeletonCard()),
    );
  }
}

class ExerciseSkeletonCard extends StatelessWidget {
  const ExerciseSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      height: 250.h,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/banner-image2.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }
}
