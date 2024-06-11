import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _MapViewState extends State<MapView> {
  final ValueNotifier<GoogleMapController?> _mapController =
      ValueNotifier<GoogleMapController?>(null);
  bool isStyleSet = false;

  @override
  void initState() {
    super.initState();

    _mapController.addListener(() {
      _loadMapTheme();
    });
  }

  void _loadMapTheme() async {
    if (!isStyleSet) {
      try {
        String mapStyle =
            await rootBundle.loadString("assets/map_theme/map_theme.json");

        _mapController.value?.setMapStyle(mapStyle);
        isStyleSet = true;
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
                _mapController.value = controller;
              },
              initialCameraPosition: const CameraPosition(
                  target: LatLng(6.4299718, 3.3344001), zoom: 13.0),
            ),
          )),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: Row(
                        children: [
                          const Expanded(child: SearchWidget()),
                          const SizedBox(
                            width: 12,
                          ),
                          IconButton(
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
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlurryButton(
                                icon: SvgPicture.asset(SvgPaths.layer,
                                    color: Colors.white),
                                boxDecoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              BlurryButton(
                                icon: SvgPicture.asset(SvgPaths.send,
                                    color: Colors.white),
                                boxDecoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                              ),
                            ],
                          ),
                          BlurryButton(
                            icon: SvgPicture.asset(
                              SvgPaths.menu,
                              color: Colors.white,
                            ),
                            label: "List of variants",
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 120,
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
}
