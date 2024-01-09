import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
  });

  final TabController? controller;
  final List<String> tabs;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    final isScrollable = tabs.length > 3;
    return TabBar(
      controller: controller,
      isScrollable: isScrollable,
      indicatorSize: TabBarIndicatorSize.label,
      tabAlignment: isScrollable ? TabAlignment.start : null,
      labelPadding: isScrollable
          ? const EdgeInsets.symmetric(horizontal: 20)
          : const EdgeInsets.all(0),
      indicatorPadding: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      onTap: onTap,
      tabs: tabs
          .map((e) => Tab(
                text: e,
              ))
          .toList(),
    );
  }
}
