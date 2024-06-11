import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:m_point_assessment/ui/widgets/home_image_tile.dart';

import '../utils/asset_paths.dart';

class HomeImagesView extends StatefulWidget {
  const HomeImagesView({super.key});

  @override
  State<HomeImagesView> createState() => _HomeImagesViewState();
}

class _HomeImagesViewState extends State<HomeImagesView> {
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

  @override
  void dispose() {
    _draggableScrollableController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        shouldCloseOnMinExtent: false,
        controller: _draggableScrollableController,
        minChildSize: 0.35,
        builder: (ctx, controller) {
          var firstImage = homeImages.first;
          List otherImages = homeImages.skip(1).toList();

          return Container(
            padding: const EdgeInsets.all(10),
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
                      );
                    }),
              ],
            ),
          );
        });
  }
}
