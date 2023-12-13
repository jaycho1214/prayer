import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/bible_books.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/presentation/widgets/form/sheet/confirm_slim_menu_form.dart';
import 'package:prayer/presentation/widgets/page_indicator.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

class VersesForm extends HookWidget {
  const VersesForm({
    super.key,
    this.onChange,
  });

  final void Function()? onChange;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    return FormBuilderField(
      name: 'verses',
      builder: (FormFieldState<List<BibleVerse>> field) =>
          (field.value?.length ?? 0) == 0
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.fromLTRB(40, 10, 10, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyTheme.primary,
                  ),
                  child: ShrinkingButton(
                    onTap: () async {
                      final resp = await ConfirmSlimMenuForm.show(
                        context,
                        title: S.of(context).delete,
                        icon: FontAwesomeIcons.trash,
                      );
                      if (resp == true) {
                        field.didChange([]);
                      }
                      onChange?.call();
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                          child: ExpandablePageView.builder(
                            controller: pageController,
                            itemCount: field.value?.length ?? 0,
                            itemBuilder: (context, index) => Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${toLocaleBibleBook(context, field.value![index].book)} ${field.value![index].chapter}:${field.value![index].verse}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      if (field.value![index].translation
                                              ?.abbreviation !=
                                          null)
                                        Text(
                                          field.value![index].translation!
                                              .abbreviation,
                                        ),
                                    ],
                                  ),
                                  Text(field.value![index].value ?? ''),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: PageIndicator(
                              itemCount: field.value?.length ?? 0,
                              controller: pageController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
