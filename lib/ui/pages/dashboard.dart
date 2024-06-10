import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/widgets/bottom_navigation_bar.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = "/dashboard";

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ValueNotifier<int> _navBarIndex = ValueNotifier(2);

  @override
  void dispose() {
    _navBarIndex.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 20,
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
          )
        ],
      ),
    );
  }
}
