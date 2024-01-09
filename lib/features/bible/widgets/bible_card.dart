import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/bible_books.dart';
import 'package:prayer/features/bible/widgets/forms/bible_translation_picker.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/model/placeholder.dart';
import 'package:prayer/features/bible/providers/bible_verse_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BibleCard extends HookConsumerWidget {
  const BibleCard({
    super.key,
    required this.verseId,
    this.margin,
  });

  final int verseId;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translation = useState(BibleTranslation.preference());
    final verse = ref.watch(bibleVerseNotifierProvider(verseId,
        translationId: translation.value.id));

    return Skeletonizer(
      enabled: verse.value == null,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).disabledColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    verse.value == null
                        ? 'PLACEHOLDER'
                        : '${toLocaleBibleBook(context, verse.value!.book)!} ${verse.value!.chapter}:${verse.value!.verse}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                PrimaryTextButton(
                  onTap: () async {
                    final resp = await BibleTranslationPicker.show(context);
                    if (resp == null) {
                      return;
                    }
                    Hive.box('settings')
                        .put('bible_translations.preference', resp.id);
                    translation.value = resp;
                  },
                  text: translation.value.abbreviation,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              verse.value == null ? LoremIpsum : verse.value!.value!,
            ),
          ],
        ),
      ),
    );
  }
}
