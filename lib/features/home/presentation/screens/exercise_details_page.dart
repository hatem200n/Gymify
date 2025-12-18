// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/core/providers/favorites_notifier.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:flutter_riverpod/src/consumer.dart';

class ExerciseDetailsPage extends ConsumerStatefulWidget {
  final ExerciseModel exercise;
  bool isFavorite;
  ExerciseDetailsPage({
    super.key,
    required this.exercise,
    this.isFavorite = false,
  });

  @override
  ConsumerState<ExerciseDetailsPage> createState() =>
      _ExerciseDetailsPageState();
}

class _ExerciseDetailsPageState extends ConsumerState<ExerciseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    widget.isFavorite =
        ref.watch(favoritesProvider).contains(widget.exercise.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildImageAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleAndFavorite(context),
                  12.verticalSpace,
                  _buildMusclesSection(context),
                  16.verticalSpace,
                  _buildInfoChips(context),
                  20.verticalSpace,
                  _buildInstructions(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildImageAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280.h,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          widget.exercise.gifUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const Center(child: Icon(Icons.image_not_supported)),
        ),
      ),
    );
  }

  Widget _buildTitleAndFavorite(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: widget.exercise.name.makeTitleText(
            context,
            fontSize: 22,
          ),
        ),
        IconButton(
          icon: Icon(
            widget.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: widget.isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            ref
                .read(favoritesProvider.notifier)
                .toggleFavorite(widget.exercise.id);
          },
        )
      ],
    );
  }

  Widget _buildMusclesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Target Muscles".makeLabelText(context),
        6.verticalSpace,
        Wrap(
          spacing: 8,
          children: widget.exercise.targetMuscles
              .map((m) => _chip(m, AppColors.primary))
              .toList(),
        ),
        if (widget.exercise.secondaryMuscles.isNotEmpty) ...[
          12.verticalSpace,
          "Secondary Muscles".makeLabelText(context),
          6.verticalSpace,
          Wrap(
            spacing: 8,
            children: widget.exercise.secondaryMuscles
                .map((m) => _chip(m, AppColors.secondary))
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoChips(BuildContext context) {
    final items = <Widget>[];

    if (widget.exercise.bodyParts.isNotEmpty) {
      items.addAll(
        widget.exercise.bodyParts.map(
          (e) => _chip(e, Colors.blueGrey),
        ),
      );
    }

    if (widget.exercise.equipments.isNotEmpty) {
      items.addAll(
        widget.exercise.equipments.map(
          (e) => _chip(e, Colors.deepPurple),
        ),
      );
    }

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Exercise Info".makeLabelText(context),
        6.verticalSpace,
        Wrap(spacing: 8, children: items),
      ],
    );
  }

  Widget _buildInstructions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Instructions".makeLabelText(context),
        8.verticalSpace,
        ...widget.exercise.instructions.map(
          (step) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.circle, size: 6),
                8.horizontalSpace,
                Expanded(
                  child: step.makeBodyText(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _chip(String text, Color color) {
    return Chip(
      label: Text(text),
      backgroundColor: color.withValues(alpha: 0.15),
      labelStyle: TextStyle(color: color),
    );
  }
}
