import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class BibleTranslationPicker extends HookWidget {
  const BibleTranslationPicker({super.key});

  static Future<BibleTranslation?> show(BuildContext context) {
    return showModalBottomSheet<BibleTranslation>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => BibleTranslationPicker(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      snapSizes: [0.5, 1],
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          const SizedBox(height: 20),
          Text(
            S.of(context).chooseTranslation,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 10),
          const Divider(),
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              itemCount: BibleTranslation.values.length,
              itemBuilder: (context, index) => ShrinkingButton(
                onTap: () => context.pop(BibleTranslation.values[index]),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        BibleTranslation.values[index].abbreviation,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        BibleTranslation.values[index].name,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
