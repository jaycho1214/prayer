import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/bible_books.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/model/placeholder.dart';
import 'package:prayer/presentation/widgets/form/sheet/bible_translation_picker.dart';
import 'package:prayer/presentation/widgets/page_indicator.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/repo/bible_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BibleCardList extends HookWidget {
  const BibleCardList({
    super.key,
    required this.verses,
  });

  final List<int> verses;

  @override
  Widget build(BuildContext context) {
    final translation = useState(BibleTranslation.preference());
    final controller = usePageController();
    return Stack(
      children: [
        ExpandablePageView.builder(
          controller: controller,
          itemCount: verses.length,
          itemBuilder: (context, index) => HookBuilder(
            builder: (context) {
              final verse = useFuture(useMemoized(
                  () => GetIt.I<BibleRepository>().fetchVerse(verses[index],
                      translationId: translation.value.id),
                  [translation.value.id]));
              return Skeletonizer(
                enabled: verse.data == null,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                  ? 'PLACEHOLDER'
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
                        verse.data == null ? LoremIpsum : verse.data!.value!,
                      ),
                    ],
                  ),
                ),
              );
            },
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
