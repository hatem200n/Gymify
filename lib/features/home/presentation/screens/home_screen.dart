import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/constants/fillter_ptions.dart';
import 'package:gymfiy/core/errors/error_retry_view.dart';
import 'package:gymfiy/core/local/storage_provider.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_notifier.dart';
import 'package:gymfiy/features/home/presentation/widgets/all-exrciecs-section/all_exercises_list.dart';
import 'package:gymfiy/features/home/presentation/widgets/banners-section/explore_list.dart';
import 'package:gymfiy/features/home/presentation/widgets/home_page_appbar.dart';
import 'package:gymfiy/features/home/presentation/widgets/banners-section/home_page_banner.dart';
import 'package:gymfiy/features/home/providers/home_providers.dart';
import 'package:gymfiy/features/search/presentation/widgets/search_text_filed.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels >=
            _controller.position.maxScrollExtent - 300) {
          ref.read(exercisesNotifierProvider(null).notifier).fetchMore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(exercisesNotifierProvider(null));
    final userName = ref.watch(userNameProvider);
    final providerNotifire = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      body: exercisesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) {
          return ErrorRetryView(
              message: e.toString(),
              onRetry: () {
                ref.invalidate(exercisesNotifierProvider(null));
              });
        },
        data: (_) {
          return ListView(
            controller: _controller,
            padding: EdgeInsets.symmetric(vertical: 15.r),
            children: [
              HomePageAppbar(
                userName: userName,
                providerNotifire: providerNotifire,
              ),
              const SearchTextFiled(),
              15.verticalSpace,
              const HomePageBanner(
                image: "assets/images/banner-image2.png",
              ),
              10.verticalSpace,
              ExploreList(
                title: "Explore by body part",
                items: FillterOptions.bodyParts,
                fillterType: "bodyparts",
              ),
              15.verticalSpace,
              ExploreList(
                title: "What about muscles",
                items: FillterOptions.equipments,
                fillterType: "muscles",
              ),
              15.verticalSpace,
              ExploreList(
                title: "Depending on the equipment as well",
                items: FillterOptions.muscles,
                fillterType: "equipments",
              ),
              15.verticalSpace,
              const AllExercisesList(title: "all exercises"),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
