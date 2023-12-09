import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/bible_books.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/presentation/widgets/form/sheet/bible_picker_Form.dart';
import 'package:prayer/presentation/widgets/form/sheet/bible_translation_picker.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/repo/bible_repository.dart';

class ProfileBibleVerseForm extends HookWidget {
  const ProfileBibleVerseForm({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = useState(BibleTranslation.preference());
    return FormBuilderField(
      name: 'verseId',
      builder: (FormFieldState<int?> field) {
        return HookBuilder(
          builder: (context) {
            final verse = useFuture(
              useMemoized(
                  () => field.value == null
                      ? null
                      : GetIt.I<BibleRepository>().fetchVerse(field.value!,
                          translationId: translation.value.id),
                  [translation.value.id, field.value]),
              preserveState: false,
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).bibleVerse,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ShrinkingButton(
                  onTap: () async {
                    final result = await BiblePicker.show(
                      context,
                      maxLength: 1,
                    );
                    field.didChange((result?.length ?? 0) > 0
                        ? result?.last.verseId
                        : null);
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
                    decoration: BoxDecoration(
                      color: MyTheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                verse.data == null
                                    ? S.of(context).bibleVerse
                                    : '${toLocaleBibleBook(context, verse.data!.book)!} ${verse.data!.chapter}:${verse.data!.verse}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ShrinkingButton(
                              onTap: () async {
                                final resp =
                                    await BibleTranslationPicker.show(context);
                                if (resp == null) {
                                  return;
                                }
                                translation.value = resp;
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: MyTheme.surface,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  translation.value.abbreviation,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          verse.data == null
                              ? S.of(context).placeholderBibleVerse
                              : verse.data!.value!,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
