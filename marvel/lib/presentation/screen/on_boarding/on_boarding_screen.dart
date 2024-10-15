import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/image_strings.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/text_strings.dart';
import '../../../core/device/device_utility.dart';
import '../../bloc/onboarding/on_boarding_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => OnBoardingBloc(),
      child: Scaffold(
        body: Stack(
          children: [
            // Horizonal scrool
            OnBoardingHorizontalScrool(size: size),
            // skip button
            const OnBoardingSkip(),
            // Indicator
            const OnBoardingDotsNavigation(),
          ],
        ),
      ),
    );
  }
}

class OnBoardingHorizontalScrool extends StatelessWidget {
  const OnBoardingHorizontalScrool({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: (value) {
        BlocProvider.of<OnBoardingBloc>(context)
            .add(NextPageEvent(page: value));
      },
      children: [
        OnBoardingPage(
          size: size,
          image: TImages.hulk,
          title: TTexts.onBoardingTitle1,
          subtitle: TTexts.onBoardingSubTitle1,
        ),
        OnBoardingPage(
          size: size,
          image: TImages.tor,
          title: TTexts.onBoardingTitle2,
          subtitle: TTexts.onBoardingSubTitle2,
        ),
        OnBoardingPage(
          size: size,
          image: TImages.deadpool,
          title: TTexts.onBoardingTitle3,
          subtitle: TTexts.onBoardingSubTitle3,
        ),
      ],
    );
  }
}

class OnBoardingDotsNavigation extends StatelessWidget {
  const OnBoardingDotsNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    int currentPage = 0;
    return BlocConsumer<OnBoardingBloc, OnBoardingState>(
      listener: (BuildContext context, OnBoardingState state) {
        if (state is OnBoardingNextPageState) {
          currentPage = state.page;
        }
      },
      builder: (BuildContext context, OnBoardingState state) {
        return Positioned(
          bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25.0,
          left: TSizes.defaultSpace,
          child: AnimatedSmoothIndicator(
              effect: const ExpandingDotsEffect(
                  activeDotColor: TColors.primary, dotHeight: 6.0),
              activeIndex: currentPage,
              count: 3),
        );
      },
    );
  }
}

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () => context.push('/home/0'),
        child: const Text('Skip'),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final Size size;
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: size.width * 0.8,
            height: size.height * 0.6,
            image: AssetImage(image),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
