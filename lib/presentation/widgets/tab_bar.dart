import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    this.controller,
  });

  final TabController? controller;
  final List<String> tabs;

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
      labelColor: MyTheme.onPrimary,
      unselectedLabelColor: MyTheme.placeholderText,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 13,
      ),
      dividerColor: MyTheme.outline,
      tabs: tabs
          .map((e) => Tab(
                text: e,
              ))
          .toList(),
    );
  }
}
