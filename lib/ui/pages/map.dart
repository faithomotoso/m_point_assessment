import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m_point_assessment/ui/utils/asset_paths.dart';
import 'package:m_point_assessment/ui/widgets/blurry_button.dart';
import 'package:m_point_assessment/ui/widgets/bottom_navigation_bar.dart';
import 'package:m_point_assessment/ui/widgets/map_marker.dart';
import 'package:m_point_assessment/ui/widgets/search.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../utils/colors.dart';

typedef PopupItem = ({String iconPath, String title});

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with TickerProviderStateMixin {
  final ValueNotifier<GoogleMapController?> mapController =
      ValueNotifier<GoogleMapController?>(null);
  final ValueNotifier<String?> mapStyleNotifier = ValueNotifier(null);

  late final AnimationController sizeAnimationController;

  final LatLng initialLatLng = const LatLng(6.4299718, 3.3344001);

  final Set<Marker> markers = {};

  late final ValueNotifier<PopupItem?> selectedPopupItem;

  final List<PopupItem> popupMenus = [
    (iconPath: SvgPaths.shield, title: "Cosy areas"),
    (iconPath: SvgPaths.wallet, title: "Price"),
    (iconPath: SvgPaths.trash, title: "Infrastructure"),
    (iconPath: SvgPaths.layer, title: "Without any layer")
  ];

  @override
  void initState() {
    selectedPopupItem = ValueNotifier(popupMenus[1])
      ..addListener(() {
        if ([popupMenus[1], popupMenus.last]
            .contains(selectedPopupItem.value)) {
          initMarkers();
        }
      });

    initMarkers();

    sizeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    mapController.addListener(() {
      Future.wait([
        _loadMapTheme(),
        Future.delayed(const Duration(milliseconds: 800))
      ]).then((value) {
        sizeAnimationController.forward();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    mapController.value?.dispose();
    mapStyleNotifier.dispose();
    sizeAnimationController.dispose();
    selectedPopupItem.dispose();
    super.dispose();
  }

  Future<void> _loadMapTheme() async {
    if ((mapStyleNotifier.value ?? "").isEmpty) {
      try {
        String mapStyle =
            await rootBundle.loadString("assets/map_theme/map_theme.json");
        mapStyleNotifier.value = mapStyle;
      } catch (e) {
        log(e.toString());
      }
    }
  }

  initMarkers() async {
    Size size = const Size(300, 300);

    bool showBuilding = selectedPopupItem.value == popupMenus.last;

    markers.clear();

    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position:
            LatLng(initialLatLng.latitude + 0.0344, initialLatLng.longitude),
        icon: await MapMarker(
          text: "11 mn",
          showBuilding: showBuilding,
        ).toBitmapDescriptor(
          logicalSize: size,
          imageSize: size,
        ),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId('2'),
        position: LatLng(
            initialLatLng.latitude - 0.0274, initialLatLng.longitude - 0.006),
        icon: await MapMarker(
          text: "13.5 mn",
          showBuilding: showBuilding,
        ).toBitmapDescriptor(
          logicalSize: size,
          imageSize: size,
        ),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId('3'),
        position: LatLng(
            initialLatLng.latitude + 0.0144, initialLatLng.longitude - 0.01),
        icon: await MapMarker(
          text: "9.85 mn",
          showBuilding: showBuilding,
        ).toBitmapDescriptor(
          logicalSize: size,
          imageSize: size,
        ),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId('4'),
        position: LatLng(
            initialLatLng.latitude + 0.0034, initialLatLng.longitude + 0.015),
        icon: await MapMarker(
          text: "6.95 mn",
          showBuilding: showBuilding,
        ).toBitmapDescriptor(
          logicalSize: size,
          imageSize: size,
        ),
      ),
    );

    setState(() {});
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
            child: ValueListenableBuilder<String?>(
                valueListenable: mapStyleNotifier,
                builder: (ctx, style, child) {
                  return GoogleMap(
                    style: style,
                    onMapCreated: (controller) {
                      mapController.value = controller;
                    },
                    initialCameraPosition:
                        CameraPosition(target: initialLatLng, zoom: 12.0),
                    markers: markers,
                  );
                }),
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
                                  child: const SearchWidget(),
                                  alignment: Alignment.topCenter)),
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
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: (AppBottomNavigationBar.getNavbarPosition().position?.dy ??
                      80) -
                  (AppBottomNavigationBar.getNavbarPosition().size?.height ??
                      100) -
                  30,
              child: KeyboardVisibilityBuilder(
                  builder: (context, isKeyboardVisible) {
                if (isKeyboardVisible) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.93,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            wrapInScaleTransition(
                              child: PopupMenuButton(
                                itemBuilder: (ctx) => List<PopupMenuEntry>.from(
                                  popupMenus.map(
                                    (e) {
                                      Color color = e == selectedPopupItem.value
                                          ? AppColors.primary
                                          : AppColors.c928F89;

                                      return PopupMenuItem(
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              e.iconPath,
                                              colorFilter: ColorFilter.mode(
                                                  color, BlendMode.srcIn),
                                              height: 20,
                                              width: 20,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              e.title,
                                              style: TextStyle(color: color),
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          selectedPopupItem.value = e;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                offset: const Offset(0, -160),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                color: Color.lerp(
                                    AppColors.primary, Colors.white, 0.95),
                                child: BlurryButton(
                                  boxShape: BoxShape.circle,
                                  icon: SvgPicture.asset(
                                    SvgPaths.layer,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                  boxDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            wrapInScaleTransition(
                              child: BlurryButton(
                                boxShape: BoxShape.circle,
                                icon: SvgPicture.asset(
                                  SvgPaths.send,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn),
                                ),
                                boxDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ],
                        ),
                        wrapInScaleTransition(
                          child: BlurryButton(
                            icon: SvgPicture.asset(
                              SvgPaths.menu,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                            label: "List of variants",
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }

  Widget wrapInScaleTransition(
          {required Widget child, Alignment alignment = Alignment.center}) =>
      ScaleTransition(
        scale: sizeAnimationController,
        alignment: alignment,
        child: child,
      );
}
