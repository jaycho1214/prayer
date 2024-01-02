import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/bible/widgets/forms/bible_picker_form.dart';
import 'package:prayer/features/corporate_prayer/widgets/sheets/corporate_prayer_form.dart';
import 'package:prayer/features/user/widgets/verses_form.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/rich_text_controller_hook.dart';
import 'package:prayer/features/common/sheets/image_picker_form.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/prayer/widgets/forms/prayer_group_form.dart';
import 'package:prayer/features/prayer/widgets/forms/confirm_pray_with_name.dart';
import 'package:prayer/features/prayer/widgets/forms/prayer_visibility_form.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/features/auth/providers/auth_state.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/repo/prayer_repository.dart';

class PrayerFormScreen extends ConsumerStatefulWidget {
  const PrayerFormScreen({
    super.key,
    this.initialValue,
    this.groupId,
    this.corporateId,
  });

  final String? initialValue;
  final String? groupId;
  final String? corporateId;

  @override
  ConsumerState<PrayerFormScreen> createState() => _PrayerFormScreenState();
}

class _PrayerFormScreenState extends ConsumerState<PrayerFormScreen> {
  final FocusNode _focusNode = FocusNode();
  final formKey = GlobalKey<FormBuilderState>();
  final _controller = RichTextController();

  int _valueTextLength = 0;
  bool _loading = false;

  Future<void> pickImage() async {
    final List<AssetEntity> initialIds =
        (formKey.currentState?.instantValue['media'] ?? []);
    final image = await PrimaryImagePicker.show(
      context,
      maxLength: 4,
      initialIds: initialIds.map((entity) => entity.id).toList(),
    );
    _focusNode.requestFocus();
    if (image == null) {
      return;
    }
    formKey.currentState?.fields['media']?.didChange(image);
  }

  Future<void> submit() async {
    if (formKey.currentState?.saveAndValidate() == true) {
      try {
        setState(() {
          _loading = true;
        });
        final form = formKey.currentState!.value;
        talker.debug('[Prayer] Posting: $form');
        if (!form['anon']) {
          final resp = await ConfirmPrayWithNameForm.show(context);
          if (resp != true) {
            setState(() {
              _loading = true;
            });
            _focusNode.requestFocus();
            return;
          }
        }
        final List<AssetEntity> media = form['media'] ?? [];
        final files = await Future.wait(media.map((e) => e.file));
        final value = await GetIt.I<PrayerRepository>().createPrayer(
          value: form['value'],
          groupId: form['groupId'],
          corporateId: form['corporateId'],
          anon: form['anon'],
          media: files.map((file) => file?.path).whereType<String>().toList(),
          verses: form['verses'] == null
              ? null
              : List<int>.from(form['verses']!.map((e) => e.verseId!).toList()),
        );
        mixpanel.track('Prayer Posted', properties: {
          'groupId': form['groupId'],
          'corporateId': form['corporateId'],
        });
        talker.good('[Prayer] Posted: $value');
        Navigator.of(context).pop(true);
      } catch (err, st) {
        talker.handle(err, st, '[Prayer] Failed to post');
        GlobalSnackBar.show(context, message: S.of(context).errorPostPrayer);
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Widget buildAnonymousFooter() {
    return FormBuilderField(
      name: 'anon',
      builder: (FormFieldState<bool> field) {
        final anon = field.value ?? false;
        return ShrinkingButton(
          onTap: () async {
            field.didChange(
                await PrayerVisibilityForm.show(context, anonymous: anon) ??
                    anon);
            _focusNode.requestFocus();
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 15),
            child: Row(
              children: [
                FaIcon(
                  anon
                      ? FontAwesomeIcons.lightUserSlash
                      : FontAwesomeIcons.lightUser,
                  size: 15,
                  color: MyTheme.onPrimary,
                ),
                const SizedBox(width: 10),
                Text(
                  !anon
                      ? S.of(context).titlePrayerPostPublicly
                      : S.of(context).titlePrayerPostAnonymously,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildGallery() {
    return FormBuilderField(
      builder: (FormFieldState<List<AssetEntity>> field) {
        if (field.value == null || field.value!.length == 0) {
          return SizedBox();
        }
        return SizedBox(
          height: 400,
          child: ListView.builder(
            cacheExtent: 5,
            itemCount: field.value?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => FutureBuilder(
              future: field.value![index]
                  .thumbnailDataWithSize(ThumbnailSize.square(300)),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SizedBox();
                }
                return Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 100),
                  child: ShrinkingButton(
                    onTap: () {
                      final newValue = field.value?..removeAt(index);
                      field.didChange([...(newValue ?? [])]);
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            snapshot.data!,
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
                );
              },
            ),
          ),
        );
      },
      name: 'media',
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _valueTextLength = _controller.text.length;
    });
    _controller.addListener(() {
      setState(() {
        _valueTextLength = _controller.text.length;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user =
        (ref.watch(authNotifierProvider).requireValue as AuthStateSignedUp)
            .user;

    return FormBuilder(
      key: formKey,
      initialValue: {
        'value': widget.initialValue,
        'groupId': widget.groupId,
        'corporateId': widget.corporateId,
        'anon': false,
      },
      child: Stack(
        children: [
          PlatformScaffold(
            backgroundColor: MyTheme.surface,
            appBar: PlatformAppBar(
              backgroundColor: MyTheme.surface,
              leading: NavigateBackButton(),
              trailingActions: [
                Center(
                  child: _loading
                      ? PlatformCircularProgressIndicator()
                      : PrimaryTextButton(
                          onTap: submit,
                          text: S.of(context).pray,
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
                          formKey.currentState?.fields['groupId']
                              ?.didChange(newGroupId);
                          formKey.currentState?.fields['corporateId']
                              ?.didChange(null);
                          _focusNode.requestFocus();
                        },
                      ),
                      FormBuilderField(
                        builder: (FormFieldState<String?> field) =>
                            field.value == null
                                ? const SizedBox()
                                : Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: CorporatePrayerForm(
                                      groupId: field.value!,
                                      onChange: (_) {
                                        _focusNode.requestFocus();
                                      },
                                    ),
                                  ),
                        name: 'groupId',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 20, 0),
                    child: FormBuilderTextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      name: 'value',
                      minLines: 5,
                      maxLines: 10,
                      maxLength: 500,
                      buildCounter: (context,
                              {required int currentLength,
                              required bool isFocused,
                              maxLength}) =>
                          null,
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
                  VersesForm(
                    onChange: () => _focusNode.requestFocus(),
                  ),
                  buildGallery(),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
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
                            FormBuilderField(
                              builder:
                                  (FormFieldState<List<BibleVerse>> field) {
                                return ShrinkingButton(
                                  onTap: () async {
                                    final newVerses = await BiblePicker.show(
                                      context,
                                      initialIds: field.value,
                                    );
                                    _focusNode.requestFocus();
                                    if (newVerses != null) {
                                      formKey.currentState?.fields['verses']
                                          ?.didChange([...newVerses]);
                                    }
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.solidBook,
                                    size: 20,
                                    color: MyTheme.onPrimary,
                                  ),
                                );
                              },
                              name: 'verses',
                            ),
                            Spacer(),
                            Text(
                              "$_valueTextLength/500",
                              style: TextStyle(color: MyTheme.placeholderText),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      buildAnonymousFooter(),
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
