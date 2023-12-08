import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:prayer/constants/bible_books.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/presentation/widgets/form/sheet/bible_picker_Form.dart';
import 'package:prayer/presentation/widgets/form/sheet/confirm_slim_menu_form.dart';
import 'package:prayer/presentation/widgets/form/sheet/image_picker_form.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/form/corporate_prayer_Form.dart';
import 'package:prayer/presentation/widgets/form/prayer_group_form.dart';
import 'package:prayer/presentation/widgets/form/sheet/confirm_pray_with_name.dart';
import 'package:prayer/presentation/widgets/form/sheet/prayer_visibility_form.dart';
import 'package:prayer/presentation/widgets/page_indicator.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/providers/auth/auth_provider.dart';
import 'package:prayer/providers/auth/auth_state.dart';
import 'package:prayer/repo/prayer_repository.dart';

class PrayerFormScreen extends HookConsumerWidget {
  const PrayerFormScreen({
    super.key,
    this.groupId,
    this.corporateId,
  });

  final String? groupId;
  final String? corporateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final user =
        (ref.watch(authNotifierProvider).requireValue as AuthStateSignedUp)
            .user;
    final anon = useState(false);
    final loading = useState(false);
    final _groupId = useState<String?>(groupId);
    final media = useState<List<AssetEntity>>([]);
    final focusNode = useFocusNode();
    final verses = useState<List<BibleVerse>>([]);
    final pageController = usePageController();
    final mediaImages = useFuture(useMemoized(
        () => Future.wait(media.value
            .map((e) => e.thumbnailDataWithSize(ThumbnailSize.square(300)))),
        [media.value]));

    final submit = useCallback(() async {
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        final form = formKey.currentState!.value;
        if (!anon.value) {
          final resp = await ConfirmPrayWithNameForm.show(context);
          if (resp != true) {
            loading.value = false;
            focusNode.requestFocus();
            return;
          }
        }
        final files = await Future.wait(media.value.map((e) => e.file));
        GetIt.I<PrayerRepository>()
            .createPrayer(
          value: form['value'],
          groupId: form['groupId'],
          corporateId: form['corporateId'],
          anon: anon.value,
          media: files.map((file) => file?.path).whereType<String>().toList(),
          verses: verses.value.map((e) => e.verseId!).toList(),
        )
            .then((value) {
          talker.good('Prayer posted: $value');
          Navigator.of(context).pop(true);
        }).catchError((e) {
          talker.error('Failed to post a prayer: $e', e);
          GlobalSnackBar.show(context, message: S.of(context).errorPostPrayer);
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }, []);

    final pickImage = useCallback(() async {
      final image = await PrimaryImagePicker.show(
        context,
        maxLength: 4,
        initialIds: media.value.map((e) => e.id).toList(),
      );
      focusNode.requestFocus();
      if (image == null) {
        return;
      }
      media.value = image;
    }, [media.value]);

    return FormBuilder(
      key: formKey,
      initialValue: {'groupId': _groupId.value, 'corporateId': corporateId},
      child: Stack(
        children: [
          PlatformScaffold(
            backgroundColor: MyTheme.surface,
            appBar: PlatformAppBar(
              backgroundColor: MyTheme.surface,
              leading: NavigateBackButton(),
              trailingActions: [
                Center(
                  child: loading.value
                      ? PlatformCircularProgressIndicator()
                      : PrimaryTextButton(
                          onTap: submit,
                          text: anon.value
                              ? S.of(context).prayAnonymoous
                              : S.of(context).pray,
                        ),
                ),
              ],
            ),
            body: GestureDetector(
              child: ListView(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      AbsorbPointer(
                        absorbing: true,
                        child: UserProfileImage(
                          profile: user.profile,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 10),
                      PrayerGroupForm(
                        onChange: (newGroupId) {
                          _groupId.value = newGroupId;
                          formKey.currentState?.fields['corporateId']
                              ?.didChange(null);
                          focusNode.requestFocus();
                        },
                      ),
                      if (_groupId.value != null) ...[
                        const SizedBox(width: 10),
                        CorporatePrayerForm(
                          groupId: _groupId.value!,
                          onChange: (_) {
                            focusNode.requestFocus();
                          },
                        ),
                      ],
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 20, 0),
                    child: FormBuilderTextField(
                      focusNode: focusNode,
                      name: 'value',
                      minLines: 5,
                      maxLines: 10,
                      autofocus: true,
                      validator: (value) {
                        if ((value ?? '').trim() == '') {
                          return S.of(context).errorEmptyPrayer;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: S.of(context).placeholderPrayer,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (verses.value.length > 0)
                    Container(
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
                            verses.value = [];
                          }
                          focusNode.requestFocus();
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                              child: ExpandablePageView.builder(
                                controller: pageController,
                                itemCount: verses.value.length,
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${toLocaleBibleBook(context, verses.value[index].book)} ${verses.value[index].chapter}:${verses.value[index].verse}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          if (verses.value[index].translation
                                                  ?.abbreviation !=
                                              null)
                                            Text(
                                              verses.value[index].translation!
                                                  .abbreviation,
                                            ),
                                        ],
                                      ),
                                      Text(verses.value[index].value ?? ''),
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
                                  itemCount: verses.value.length,
                                  controller: pageController,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: media.value.length > 0 ? 400 : 0,
                    child: ListView.builder(
                      cacheExtent: 5,
                      itemCount: mediaImages.data?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => mediaImages
                                  .data?[index] ==
                              null
                          ? const SizedBox()
                          : Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 0, 100),
                              child: ShrinkingButton(
                                onTap: () {
                                  media.value = [
                                    ...media.value..removeAt(index)
                                  ];
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        mediaImages.data![index]!,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.centerLeft,
                                        height: 200,
                                        width: 150,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: MyTheme.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: FaIcon(
                                          FontAwesomeIcons.xmark,
                                          size: 15,
                                          color: MyTheme.onPrimary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
            child: Container(
              color: MyTheme.surface,
              child: Stack(
                children: [
                  Divider(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: ShrinkingButton(
                                onTap: pickImage,
                                child: FaIcon(
                                  FontAwesomeIcons.image,
                                  size: 20,
                                  color: MyTheme.onPrimary,
                                ),
                              ),
                            ),
                            ShrinkingButton(
                              onTap: () async {
                                final newVerses = await BiblePicker.show(
                                  context,
                                  initialIds: verses.value,
                                );
                                verses.value = newVerses ?? [];
                                focusNode.requestFocus();
                              },
                              child: FaIcon(
                                FontAwesomeIcons.solidBook,
                                size: 20,
                                color: MyTheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      ShrinkingButton(
                        onTap: () async {
                          anon.value = await PrayerVisibilityForm.show(context,
                                  anonymous: anon.value) ??
                              anon.value;
                          focusNode.requestFocus();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 15),
                          child: Row(
                            children: [
                              FaIcon(
                                anon.value
                                    ? FontAwesomeIcons.lightUserSlash
                                    : FontAwesomeIcons.lightUser,
                                size: 15,
                                color: MyTheme.onPrimary,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                !anon.value
                                    ? S.of(context).titlePrayerPostPublicly
                                    : S.of(context).titlePrayerPostAnonymously,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
