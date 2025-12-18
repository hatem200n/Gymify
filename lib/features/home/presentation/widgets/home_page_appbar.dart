
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/router/go_router_provider.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_notifier.dart';

class HomePageAppbar extends StatelessWidget {
  const HomePageAppbar({
    super.key,
    required this.userName,
    required this.providerNotifire,
  });

  final String userName;
  final AuthNotifier providerNotifire;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: "Get Ready $userName".makeTitleText(context),
      subtitle: "we have a plan for you".makeBodyText(context),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () {
                context.push(AppRoutes.favoritesScreen);

          }, icon: const Icon(Icons.favorite)),
          IconButton(
              onPressed: () {
                providerNotifire.signOut();
                context.go(AppRoutes.onboarding);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
