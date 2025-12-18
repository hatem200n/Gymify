import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/router/go_router_provider.dart';

class SearchTextFiled extends StatelessWidget {
  const SearchTextFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(AppRoutes.searchPage);
      },
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: "Search exercises...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
