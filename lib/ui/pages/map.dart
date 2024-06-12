import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m_point_assessment/ui/utils/asset_paths.dart';
import 'package:m_point_assessment/ui/widgets/blurry_button.dart';
import 'package:m_point_assessment/ui/widgets/search.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with TickerProviderStateMixin {
  final ValueNotifier<GoogleMapController?> mapController =
      ValueNotifier<GoogleMapController?>(null);
  bool isStyleSet = false;

  late final AnimationController sizeAnimationController;

  @override
  void initState() {
    super.initState();

    sizeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    mapController.addListener(() {
      _loadMapTheme();
    });
  }

  @override
  void dispose() {
    mapController.value?.dispose();
    sizeAnimationController.dispose();
    super.dispose();
  }

  void _loadMapTheme() async {
    if (!isStyleSet) {
      try {
        String mapStyle =
            await rootBundle.loadString("assets/map_theme/map_theme.json");

        mapController.value?.setMapStyle(mapStyle);
        isStyleSet = true;

        sizeAnimationController.forward();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController.value = controller;
              },
              initialCameraPosition: const CameraPosition(
                  target: LatLng(6.4299718, 3.3344001), zoom: 13.0),
            ),
          )),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: Row(
                        children: [
                          Expanded(
                              child: wrapInScaleTransition(
                                  child: const SearchWidget())),
                          const SizedBox(
                            width: 12,
                          ),
                          wrapInScaleTransition(
                            child: IconButton(
                              constraints: const BoxConstraints(
                                  minHeight: 56, minWidth: 56),
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                SvgPaths.settings,
                                height: 20,
                                width: 20,
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                        if (isKeyboardVisible) {
                          return const SizedBox();
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  wrapInScaleTransition(
                                    child: BlurryButton(
                                      icon: SvgPicture.asset(SvgPaths.layer,
                                          color: Colors.white),
                                      boxDecoration:
                                          const BoxDecoration(shape: BoxShape.circle),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  wrapInScaleTransition(
                                    child: BlurryButton(
                                      icon: SvgPicture.asset(SvgPaths.send,
                                          color: Colors.white),
                                      boxDecoration:
                                          const BoxDecoration(shape: BoxShape.circle),
                                    ),
                                  ),
                                ],
                              ),
                              wrapInScaleTransition(
                                child: BlurryButton(
                                  icon: SvgPicture.asset(
                                    SvgPaths.menu,
                                    color: Colors.white,
                                  ),
                                  label: "List of variants",
                                  boxDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget wrapInScaleTransition({required Widget child}) => ScaleTransition(
        scale: sizeAnimationController,
        child: child,
      );
}
