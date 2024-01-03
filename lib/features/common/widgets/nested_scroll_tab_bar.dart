import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/tab_bar.dart';

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  const TabBarDelegate({
    required this.tabs,
    this.controller,
    this.maxExtent = 48,
    this.minExtent = 48,
    this.onTap,
  });

  final TabController? controller;
  final List<String> tabs;
  final double minExtent;
  final double maxExtent;
  final void Function(int)? onTap;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.bottomCenter,
      color: MyTheme.surface,
      child: CustomTabBar(
        tabs: tabs,
        controller: controller,
        onTap: onTap,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
