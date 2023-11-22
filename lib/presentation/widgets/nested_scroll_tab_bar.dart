import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/tab_bar.dart';

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  const TabBarDelegate({
    required this.tabs,
  });

  final List<String> tabs;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: MyTheme.surface,
      child: CustomTabBar(tabs: tabs),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
