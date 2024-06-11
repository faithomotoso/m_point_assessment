import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_point_assessment/ui/utils/asset_paths.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller =
      TextEditingController(text: "Saint Petersburg");

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      backgroundColor: const MaterialStatePropertyAll(Colors.white),
      surfaceTintColor: const MaterialStatePropertyAll(Colors.white),
      hintText: "Search",
      leading: SvgPicture.asset(SvgPaths.searchOutlined),
    );
  }
}
