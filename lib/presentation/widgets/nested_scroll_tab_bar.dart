import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/tab_bar.dart';

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  const TabBarDelegate({
    required this.tabs,
    this.controller,
    this.maxExtent = 48,
    this.minExtent = 48,
  });

  final TabController? controller;
  final List<String> tabs;
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.bottomCenter,
      color: MyTheme.surface,
      child: CustomTabBar(
        tabs: tabs,
        controller: controller,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
