import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/constants/app_data.dart';
import 'package:gymfiy/core/local/storage_provider.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_notifier.dart';
import 'package:gymfiy/features/home/presentation/widgets/all_exercises_list.dart';
import 'package:gymfiy/features/home/presentation/widgets/explore_list.dart';
import 'package:gymfiy/features/home/presentation/widgets/home_page_appbar.dart';
import 'package:gymfiy/features/home/presentation/widgets/home_page_banner.dart';
import 'package:gymfiy/features/home/providers/home_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
          ref.read(exercisesNotifierProvider.notifier).fetchMore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(exercisesNotifierProvider);
    final userName = ref.watch(userNameProvider);
    final providerNotifire = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      body: exercisesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('❌ فشل التحميل: $e')),
        data: (_) {
          return ListView(
            controller: _controller,
            padding: EdgeInsets.symmetric(vertical: 15.r),
            children: [
              HomePageAppbar(
                userName: userName,
                providerNotifire: providerNotifire,
              ),
              const HomePageBanner(),
              10.verticalSpace,
              ExploreList(
                title: "Explore by body part",
                items: ExploerData.bodyParts,
                fillterType: "bodyparts",
              ),
              15.verticalSpace,
              ExploreList(
                title: "What about muscles",
                items: ExploerData.equipments,
                fillterType: "muscles",
              ),
              15.verticalSpace,
              ExploreList(
                title: "Depending on the equipment as well",
                items: ExploerData.muscles,
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

// class filltredExercises extends ConsumerStatefulWidget {
//   final String? fillterType;
//   final String? fillterValue;
//   const filltredExercises(
//       {super.key, required this.fillterType, required this.fillterValue});

//   @override
//   ConsumerState<filltredExercises> createState() => _filltredExercises();
// }

// class _filltredExercises extends ConsumerState<filltredExercises> {
//   late final ScrollController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = ScrollController()
//       ..addListener(() {
//         if (_controller.position.pixels >=
//             _controller.position.maxScrollExtent - 300) {
//           ref.read(exercisesNotifierProvider(null, null).notifier).fetchMore();
//         }
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final exercisesAsync = ref.watch(exercisesNotifierProvider(null, null));

//     return Scaffold(
//       body: exercisesAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, _) => Center(child: Text('❌ فشل التحميل: $e')),
//         data: (_) {
//           return ListView(
//             controller: _controller,
//             padding: EdgeInsets.symmetric(vertical: 15.r),
//             children: [
//               AllExercisesList(
//                 title: "all exercises",
//                 fillterType: widget.fillterType,
//                 fillterValue: widget.fillterValue,
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
