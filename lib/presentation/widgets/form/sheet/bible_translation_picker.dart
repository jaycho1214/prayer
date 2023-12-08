import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

class BibleTranslationPicker extends HookWidget {
  const BibleTranslationPicker({super.key});

  static Future<BibleTranslation?> show(BuildContext context) {
    return showModalBottomSheet<BibleTranslation>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: MyTheme.sheetSurface,
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => BibleTranslationPicker(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      snapSizes: [0.5, 1],
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: MyTheme.sheetSurface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              S.of(context).chooseGroup,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
            ),
            const SizedBox(height: 10),
            Divider(color: MyTheme.outline),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                itemCount: BibleTranslation.values.length,
                itemBuilder: (context, index) => ShrinkingButton(
                  onTap: () => context.pop(BibleTranslation.values[index]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          BibleTranslation.values[index].abbreviation,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          BibleTranslation.values[index].name,
                          style:
                              TextStyle(fontSize: 13, color: MyTheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) =>
                    const Divider(color: MyTheme.outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
