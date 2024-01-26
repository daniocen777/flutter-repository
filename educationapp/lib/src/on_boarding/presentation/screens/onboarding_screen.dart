import 'package:educationapp/core/common/views/loading_view.dart';
import 'package:educationapp/core/common/widgets/gradient_background.dart';
import 'package:educationapp/core/resources/colours.dart';
import 'package:educationapp/core/resources/media_resource.dart';
import 'package:educationapp/src/on_boarding/domain/entities/page_content.dart';
import 'package:educationapp/src/on_boarding/presentation/cubits/on_boarding_cubit.dart';
import 'package:educationapp/src/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    // Se puede usar el cubit, ya que el provider esta en las rutas
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaResource.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatus && !state.isFirstTimer) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is UserCachedState) {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          builder: (BuildContext context, OnBoardingState state) {
            if (state is CheckIfUserIsFirstTimerState ||
                state is CachingFirstTimerState) {
              return const LoadingView();
            }
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnBoardingBody(pageContent: PageContent.first()),
                    OnBoardingBody(pageContent: PageContent.second()),
                    OnBoardingBody(pageContent: PageContent.third()),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, 0.04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: Colours.primaryColour,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
