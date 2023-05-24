import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:faker/faker.dart';
import 'package:my_widgets/facebook_ui/widgets/circle_button.dart';
import 'package:my_widgets/facebook_ui/widgets/publicationItem.dart';
import 'package:my_widgets/facebook_ui/widgets/quick_actions.dart';
import 'package:my_widgets/facebook_ui/widgets/stories.dart';
import 'package:my_widgets/facebook_ui/widgets/what_is_on_your_mind.dart';
import 'package:my_widgets/icons/suctom_icons.dart';
import 'package:my_widgets/models/publication.dart';

class FacebookUi extends StatelessWidget {
  const FacebookUi({super.key});

  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    final publications = <Publication>[];
    for (int i = 0; i < 50; i++) {
      final random = faker.randomGenerator;
      const reactions = Reaction.values;
      final reactionIndex = random.integer(reactions.length - 1);
      final publication = Publication(
        title: faker.lorem.sentence(),
        createdAt: faker.date.dateTime(),
        imageUrl: faker.image.image(),
        commetsCount: random.integer(50000),
        sharesCount: random.integer(50000),
        user: User(avatar: faker.image.image(), username: faker.person.name()),
        currentUserReaction: reactions[reactionIndex],
      );
      publications.add(publication);
    }

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
        children: [
          const SizedBox(height: 10.0),
          const WhatIsOnYourMind(),
          const SizedBox(height: 30.0),
          const QuickActions(),
          const SizedBox(height: 30.0),
          const Stories(),
          const SizedBox(height: 20.0),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: publications.length,
            shrinkWrap: true,
            itemBuilder: (_, index) => PublicationItem(
              publication: publications[index],
            ),
          ),
        ],
      ),
    );
  }
}
