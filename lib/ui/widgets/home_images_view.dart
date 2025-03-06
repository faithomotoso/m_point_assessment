import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:m_point_assessment/ui/widgets/home_image_tile.dart';

import '../utils/asset_paths.dart';

class HomeImagesView extends StatefulWidget {
  final AnimationController slideAnimationController;

  const HomeImagesView(
      {required this.slideAnimationController,
      super.key});

  @override
  State<HomeImagesView> createState() => _HomeImagesViewState();
}

class _HomeImagesViewState extends State<HomeImagesView>
    with TickerProviderStateMixin {
  final List<({String assetPath, String address, bool? extendHeight})>
      homeImages = [
    (assetPath: ImagePaths.img1, address: "Glasgow, UK.", extendHeight: null),
    (
      assetPath: ImagePaths.img2,
      address: "12 Elm Close, Brighton",
      extendHeight: true
    ),
    (
      assetPath: ImagePaths.img3,
      address: "3 Mill Lane, Manchester",
      extendHeight: null
    ),
    (
      assetPath: ImagePaths.img4,
      address: "8 Croft Terrace, Edinburgh",
      extendHeight: null
    ),
  ];

  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();

  late final Animation<Offset> slideOffsetAnimation;

  late final AnimationController addressScaleAnimationController;

  @override
  void initState() {
    super.initState();

    slideOffsetAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: widget.slideAnimationController,
                curve: Curves.fastEaseInToSlowEaseOut));

    addressScaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );

    widget.slideAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        Future.delayed(
            Duration(
                milliseconds:
                    (widget.slideAnimationController.duration!.inMilliseconds *
                            0.8)
                        .round()), () {
          addressScaleAnimationController.forward();
        });
      }
    });

  }

  @override
  void dispose() {
    _draggableScrollableController.dispose();
    addressScaleAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ({double initialSize, double minSize}) verticalSizeConfig =
        switch (MediaQuery.sizeOf(context).height) {
      > 600 => (initialSize: 0.5, minSize: 0.45),
      _ => (initialSize: 0.35, minSize: 0.30)
    };

    return SlideTransition(
      position: slideOffsetAnimation,
      child: DraggableScrollableSheet(
          shouldCloseOnMinExtent: false,
          controller: _draggableScrollableController,
          initialChildSize: verticalSizeConfig.initialSize,
          minChildSize: verticalSizeConfig.minSize,
          builder: (ctx, controller) {
            var firstImage = homeImages.first;
            List otherImages = homeImages.skip(1).toList();

            return Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
              ),
              child: ListView(
                controller: controller,
                padding: EdgeInsets.zero,
                children: [
                  HomeImageTile(
                    imagePath: firstImage.assetPath,
                    address: firstImage.address,
                    addressAlignment: TextAlign.center,
                    scaleAnimationController: addressScaleAnimationController,
                  ),
                  const SizedBox(height: 8),
                  MasonryGridView.count(
                      controller: controller,
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      itemCount: otherImages.length,
                      itemBuilder: (ctx, index) {
                        var imageRecord = otherImages.elementAt(index);
                        return HomeImageTile(
                          imagePath: imageRecord.assetPath,
                          address: imageRecord.address,
                          extendVertical: imageRecord.extendHeight ?? false,
                          scaleAnimationController:
                              addressScaleAnimationController,
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }
}
