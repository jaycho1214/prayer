import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer/presentation/widgets/bibles/bible_card.dart';
import 'package:prayer/presentation/widgets/page_indicator.dart';

class BibleCardList extends HookWidget {
  const BibleCardList({
    super.key,
    required this.verses,
  });

  final List<int> verses;

  @override
  Widget build(BuildContext context) {
    final controller = usePageController();
    return Stack(
      children: [
        ExpandablePageView.builder(
          controller: controller,
          itemCount: verses.length,
          itemBuilder: (context, index) => BibleCard(
            verseId: verses[index],
            margin: const EdgeInsets.symmetric(horizontal: 5),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child:
              PageIndicator(itemCount: verses.length, controller: controller),
        ),
      ],
    );
  }
}
