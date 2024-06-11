import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_point_assessment/ui/utils/asset_paths.dart';
import 'package:m_point_assessment/ui/widgets/search.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.black),
          )),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: Row(
                        children: [
                          Expanded(child: const SearchWidget()),
                          const SizedBox(
                            width: 12,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              SvgPaths.settings,
                              height: 30,
                              width: 30,
                            ),
                            color: Colors.pink,
                          )
                        ],
                      ),
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
