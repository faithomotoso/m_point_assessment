import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/pages/home.dart';
import 'package:m_point_assessment/ui/pages/map.dart';
import 'package:m_point_assessment/ui/widgets/bottom_navigation_bar.dart';

final ValueNotifier<bool> animationsComplete = ValueNotifier(false);

class Dashboard extends StatefulWidget {
  static const String routeName = "/dashboard";

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ValueNotifier<int> _navBarIndex = ValueNotifier(2);
  final ValueNotifier<bool> _showNavbar = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    animationsComplete.addListener(() {
      if (animationsComplete.value) {
        _showNavbar.value = true;
      }
    });
  }

  @override
  void dispose() {
    _navBarIndex.dispose();
    _showNavbar.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ValueListenableBuilder<int>(
              valueListenable: _navBarIndex,
              builder: (ctx, index, child) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  child: switch (index) {
                    0 => const MapView(),
                    2 => const HomePage(),
                    _ => const SizedBox()
                  },
                );
              },
            ),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: _showNavbar,
              builder: (ctx, show, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  bottom: show ? 20 : -100,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ValueListenableBuilder<int>(
                        valueListenable: _navBarIndex,
                        builder: (ctx, idx, child) {
                          return AppBottomNavigationBar(
                            selectedIndex: idx,
                            onItemSelected: (i) {
                              _navBarIndex.value = i;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
