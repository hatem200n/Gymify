import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/common/widgets/primary_button.dart';
import 'package:gymfiy/core/constants/fillter_ptions.dart';
import 'package:gymfiy/core/model/explore_item.dart';
import 'package:gymfiy/core/router/go_router_provider.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> selectedMuscles = {};
  final Set<String> selectedEquipments = {};
  final Set<String> selectedBodyParts = {};
  String sortBy = 'name';
  String sortOrder = 'asc';

  void _openResults() {
    final args = (
      search: _searchController.text.isEmpty ? null : _searchController.text,
      muscles: selectedMuscles.isEmpty ? null : selectedMuscles.toList(),
      equipments:
          selectedEquipments.isEmpty ? null : selectedEquipments.toList(),
      bodyParts: selectedBodyParts.isEmpty ? null : selectedBodyParts.toList(),
      sortBy: sortBy,
      sortOrder: sortOrder,
    );

    GoRouter.of(context).push(AppRoutes.searchResultsPage, extra: args);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Exercises"),
        surfaceTintColor: AppColors.lightBackground,
        backgroundColor: AppColors.lightBackground,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: ListView(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.hintText),
                    borderRadius: BorderRadius.circular(20.r)),
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            16.verticalSpace,
            _buildMultiSelect(
              title: 'Muscles',
              items: FillterOptions.muscles,
              selected: selectedMuscles,
              onTap: (item) {
                setState(() {
                  selectedMuscles.contains(item)
                      ? selectedMuscles.remove(item)
                      : selectedMuscles.add(item);
                });
              },
            ),
            _buildMultiSelect(
              title: 'Equipments',
              items: FillterOptions.equipments,
              selected: selectedEquipments,
              onTap: (item) {
                setState(() {
                  selectedEquipments.contains(item)
                      ? selectedEquipments.remove(item)
                      : selectedEquipments.add(item);
                });
              },
            ),
            _buildMultiSelect(
              title: 'Body Parts',
              items: FillterOptions.bodyParts,
              selected: selectedBodyParts,
              onTap: (item) {
                setState(() {
                  selectedBodyParts.contains(item)
                      ? selectedBodyParts.remove(item)
                      : selectedBodyParts.add(item);
                });
              },
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: sortBy,
                    items: ['name', 'exerciseId']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => sortBy = v!),
                    decoration: const InputDecoration(labelText: 'Sort By'),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: sortOrder,
                    items: ['asc', 'desc']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => sortOrder = v!),
                    decoration: const InputDecoration(labelText: 'Order'),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            PrimaryButton(text: "Search", onPressed: _openResults)
          ],
        ),
      ),
    );
  }

  Widget _buildMultiSelect({
    required String title,
    required List<ExploreItem> items,
    required Set<String> selected,
    required void Function(String) onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.makeTitleText(context),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: items.map((item) {
            final isSelected = selected.contains(item.name);
            return ChoiceChip(
              label: item.name.makeBodyText(context),
              selected: isSelected,
              onSelected: (_) => onTap(item.name),
              selectedColor: Colors.blueAccent,
              backgroundColor: Colors.grey.shade200,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
        16.verticalSpace
      ],
    );
  }
}
