import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_widgets/facebook_ui/widgets/circle_button.dart';
import 'package:my_widgets/facebook_ui/widgets/quick_actions.dart';
import 'package:my_widgets/facebook_ui/widgets/stories.dart';
import 'package:my_widgets/facebook_ui/widgets/what_is_on_your_mind.dart';
import 'package:my_widgets/icons/suctom_icons.dart';

class FacebookUi extends StatelessWidget {
  const FacebookUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        leadingWidth: 150,
        elevation: 0.0, // quitar la sombra
        leading: SvgPicture.asset(
          'assets/logos/facebook.svg',
          color: Colors.blueAccent,
          width: 150.0,
        ),
        actions: const [
          CircleButton(
            color: Color(0xffBFBFBF),
            iconData: CustomIcons.search,
          ),
          SizedBox(width: 15.0),
          CircleButton(
            color: Color(0xffFE7574),
            iconData: CustomIcons.bell,
          ),
          SizedBox(width: 15.0),
          CircleButton(
            color: Color(0xff7BBAFF),
            iconData: CustomIcons.userFriends,
            showBadge: true,
          ),
          SizedBox(width: 15.0),
          CircleButton(
            color: Color(0xff1C86E4),
            iconData: CustomIcons.messenger,
          ),
          SizedBox(width: 15.0),
        ],
      ),
      body: ListView(
        children: const [
          SizedBox(height: 10.0),
          WhatIsOnYourMind(),
          SizedBox(height: 30.0),
          QuickActions(),
          SizedBox(height: 30.0),
          Stories()
        ],
      ),
    );
  }
}
