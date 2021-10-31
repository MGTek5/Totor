import 'package:flutter/widgets.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:totor/utils/nav_list.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      items: getNavList(),
      onTap: (index) {
        navigateTo(context: context, index: index);
      },
      currentIndex: getRouteIndex(context: context),
    );
  }
}
