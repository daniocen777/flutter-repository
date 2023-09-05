import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(
      {required this.title, required this.caption, required this.imageUrl});
}

final slides = <SlideInfo>[
  SlideInfo(
    title: 'Buscar la comida',
    caption:
        'Occaecat commodo ad exercitation sunt ullamco. Sint proident proident consequat ut aute cillum fugiat in. Mollit commodo culpa quis fugiat amet in ullamco et consectetur nostrud adipisicing tempor reprehenderit irure. Sint voluptate amet Lorem incididunt. Deserunt deserunt sit voluptate laboris sint in.',
    imageUrl: 'assets/images/1.png',
  ),
  SlideInfo(
    title: 'Entrega rápida',
    caption:
        'Proident id mollit est ipsum ex ex incididunt magna aute consectetur commodo officia ad. Anim aute officia nostrud aute sit aute magna reprehenderit est officia veniam fugiat sunt culpa. Dolor ipsum ad labore sit culpa reprehenderit anim labore nulla excepteur sit. Deserunt cupidatat excepteur dolore minim. Cillum adipisicing irure et pariatur qui cillum exercitation cillum quis aliquip est. Dolore id dolore in aute ea ipsum ipsum amet eu non.',
    imageUrl: 'assets/images/2.png',
  ),
  SlideInfo(
    title: 'Disfruta la comida',
    caption:
        'Occaecat dolor Lorem est pariatur irure amet dolor magna eiusmod non. Veniam ipsum laborum sit deserunt nulla eiusmod mollit laboris. Reprehenderit laboris consectetur qui sint reprehenderit aliqua et. Veniam minim magna eiusmod veniam ut fugiat enim dolore ut incididunt esse enim. Adipisicing dolore aute sit consectetur sit nulla mollit tempor sunt quis culpa officia do. Culpa quis et et velit fugiat reprehenderit pariatur. Et pariatur cillum sunt occaecat sint aliquip eu anim dolor proident ad sint.',
    imageUrl: 'assets/images/3.png',
  ),
];

class AppTutorialScreen extends StatefulWidget {
  const AppTutorialScreen({super.key});

  static const name = 'app_tutorial_screen';

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  final pageController = PageController();
  bool endSlide = false;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      final page = pageController.page ?? 0;
      if (!endSlide && page >= (slides.length - 1.5)) {
        setState(() {
          endSlide = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            children: slides
                .map((slideData) => _Slide(
                      title: slideData.title,
                      caption: slideData.caption,
                      imageUrl: slideData.imageUrl,
                    ))
                .toList(),
          ),
          Positioned(
            right: 20.0,
            top: 50.0,
            child: TextButton(
              onPressed: () => context.pop(),
              child: const Text('Salir'),
            ),
          ),
          endSlide
              ? Positioned(
                  bottom: 30.0,
                  right: 30.0,
                  child: FadeInRight(
                    from: 15.0,
                    delay: const Duration(seconds: 1),
                    child: FilledButton(
                      onPressed: () => context.pop(),
                      child: const Text('Comenzar'),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide(
      {required this.title, required this.caption, required this.imageUrl});

  final String title;
  final String caption;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(imageUrl),
          ),
          const SizedBox(height: 20.0),
          Text(
            title,
            style: titleStyle,
          ),
          const SizedBox(height: 20.0),
          Text(
            caption,
            style: captionStyle,
          ),
        ],
      )),
    );
  }
}
