import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/model/explore_item.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/home/presentation/widgets/banners-section/exploer_list_card.dart';

class ExploreList extends StatelessWidget {
  final String title;
  final List<ExploreItem> items;
  final String fillterType;

  const ExploreList({
    super.key,
    required this.title,
    required this.items,
    required this.fillterType,
  });

  @override
  Widget build(BuildContext context) {
    final previewItems = items.take(7).toList();

    return Column(
      spacing: 5.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: title.makeTitleText(context),
        ),
        SizedBox(
          height: 150.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            itemCount: previewItems.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = previewItems[index];
              return ExploerListCard(item: item, fillterType: fillterType);
            },
          ),
        ),
      ],
    );
  }
}
