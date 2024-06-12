import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/utils/asset_paths.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';
import 'package:m_point_assessment/ui/widgets/home_images_view.dart';
import 'package:m_point_assessment/ui/widgets/home_welcome_text.dart';
import 'package:m_point_assessment/ui/widgets/location_overview.dart';
import 'package:m_point_assessment/ui/widgets/profile_avatar.dart';
import 'package:m_point_assessment/ui/widgets/stats.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController topSectionAnimationController;
  late final AnimationController hiNameAnimationController;
  late final AnimationController headlineTextAnimationController;

  late final AnimationController statsVisibilityAnimController;
  late final AnimationController statsNumberAnimController;
  late final Animation<double> statsVisibilityAnimation;

  @override
  void initState() {
    super.initState();

    topSectionAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    hiNameAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));

    headlineTextAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    statsVisibilityAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    statsNumberAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    statsVisibilityAnimation = CurvedAnimation(
        parent: statsVisibilityAnimController, curve: Curves.fastOutSlowIn);

    // Starts the first animation
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      topSectionAnimationController.forward();
    });

    topSectionAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Trigger animation for `Hi xyz` text
        hiNameAnimationController.forward();
      }
    });

    hiNameAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        headlineTextAnimationController.forward();
      }
    });

    headlineTextAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        Future.delayed(
            Duration(
              milliseconds:
                  (headlineTextAnimationController.duration!.inMilliseconds *
                          0.8)
                      .round(),
            ), () {
          statsVisibilityAnimController.forward();
          statsNumberAnimController.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    topSectionAnimationController.dispose();
    hiNameAnimationController.dispose();
    headlineTextAnimationController.dispose();
    statsVisibilityAnimController.dispose();
    statsNumberAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.05),
              AppColors.primary.withOpacity(0.1),
              AppColors.primary.withOpacity(0.2),
              AppColors.primary.withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
                child: ListView(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 10),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LocationOverview(
                            widthAnimationController:
                                topSectionAnimationController,
                          ),
                          ProfileAvatar(
                            assetPath: ImagePaths.profileImage,
                            animationController: topSectionAnimationController,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      HomeWelcomeText(
                        hiNameAnimController: hiNameAnimationController,
                        headlineTextAnimController:
                            headlineTextAnimationController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Stats(
                                title: "BUY",
                                number: 1034,
                                boxDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary),
                                numberAnimationController:
                                    statsNumberAnimController,
                                animation: statsVisibilityAnimation,
                                textColor: Colors.white),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Stats(
                                title: "RENT",
                                number: 2212,
                                boxDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        end: Alignment.bottomRight,
                                        begin: Alignment.topLeft,
                                        colors: [
                                          Colors.white.withOpacity(0.5),
                                          Colors.white.withOpacity(0.7),
                                          Colors.white.withOpacity(0.9),
                                          Colors.white
                                        ])),
                                numberAnimationController:
                                    statsNumberAnimController,
                                animation: statsVisibilityAnimation,
                                textColor: AppColors.c93846B),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
            const Positioned.fill(child: HomeImagesView())
          ],
        ),
      ),
    );
  }
}
