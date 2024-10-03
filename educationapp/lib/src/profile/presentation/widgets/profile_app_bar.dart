import 'dart:async';

import 'package:educationapp/core/common/widgets/popup_item.dart';
import 'package:educationapp/core/extensions/context_extension.dart';
import 'package:educationapp/core/resources/colours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Account',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
      ),
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          icon: const Icon(Icons.more_horiz),
          surfaceTintColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              onTap: () => context.push(const Placeholder()),
              child: const PopupItem(
                title: 'Edit Profile',
                icon: Icon(
                  Icons.edit,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            const PopupMenuItem<void>(
              child: PopupItem(
                title: 'Notification',
                icon: Icon(
                  IconlyLight.notification,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              height: 1,
              padding: EdgeInsets.zero,
              child: Divider(
                height: 1,
                color: Colors.grey.shade300,
                indent: 16,
                endIndent: 16,
              ),
            ),
            const PopupMenuItem<void>(
              child: PopupItem(
                title: 'Help',
                icon: Icon(
                  Icons.help_outline_outlined,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              onTap: () async {
                final navigator = Navigator.of(context);
                await FirebaseAuth.instance.signOut();
                unawaited(
                  navigator.pushNamedAndRemoveUntil('/', (route) => false),
                );
              },
              child: const PopupItem(
                title: 'Logout',
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
