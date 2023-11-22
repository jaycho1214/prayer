import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/form/sheet/image_picker_form.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

void showPicker(
  BuildContext context, {
  void Function(String?)? onChange,
  dynamic initialValue,
  double ratioX = 1.0,
  double ratioY = 1.0,
}) {
  ImagePickerForm.show(
    context,
    onTap: (menu) async {
      if (menu == ImagePickerMenuType.delete) {
        return onChange?.call(null);
      }
      if (menu == ImagePickerMenuType.reset) {
        return onChange?.call(initialValue);
      }
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image == null) {
        return;
      }
      final cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(
          ratioX: ratioX,
          ratioY: ratioY,
        ),
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );
      if (cropped == null) {
        return;
      }
      onChange?.call(cropped.path);
    },
    initialValue: initialValue,
  );
}

class ProfileImageForm extends StatelessWidget {
  const ProfileImageForm({
    super.key,
    this.initialValue,
  });

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: 'profile',
        builder: (FormFieldState<String?> field) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyTheme.surface,
                ),
                padding: const EdgeInsets.all(5),
                child: ShrinkingButton(
                  onTap: () => showPicker(context,
                      onChange: field.didChange, initialValue: initialValue),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: MyTheme.surfaceContainer,
                      shape: BoxShape.circle,
                    ),
                    width: 100,
                    height: 100,
                    child: field.value != null
                        ? field.value!.startsWith('https')
                            ? Image.network(
                                field.value!,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox(),
                              )
                            : Image.file(
                                File(field.value!),
                              )
                        : const SizedBox(),
                  ),
                ),
              ),
              const Positioned(
                right: 5,
                bottom: 5,
                child: FaIcon(FontAwesomeIcons.solidPenCircle,
                    color: MyTheme.onPrimary),
              ),
            ],
          );
        });
  }
}

class BannerImageForm extends StatelessWidget {
  const BannerImageForm({
    super.key,
    this.name = 'banner',
    this.initialValue,
    this.aspectRatio = 1.0,
    this.size,
  });

  final String name;
  final String? initialValue;
  final double aspectRatio;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final _size = size ?? MediaQuery.of(context).size.width;
    return FormBuilderField(
        name: name,
        builder: (FormFieldState<String?> field) {
          return Stack(
            children: [
              ShrinkingButton(
                onTap: () => showPicker(
                  context,
                  onChange: field.didChange,
                  initialValue: initialValue,
                  ratioX: 1.0,
                  ratioY: 1.0 * aspectRatio,
                ),
                child: Container(
                  color: MyTheme.surfaceContainer,
                  width: _size,
                  height: _size * aspectRatio,
                  child: field.value != null
                      ? field.value!.startsWith('https')
                          ? Image.network(
                              field.value!,
                              errorBuilder: (context, error, stackTrace) =>
                                  const SizedBox(),
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(field.value!),
                              fit: BoxFit.cover,
                            )
                      : const SizedBox(),
                ),
              ),
              const Positioned(
                right: 5,
                bottom: 5,
                child: FaIcon(
                  FontAwesomeIcons.solidPenCircle,
                  color: MyTheme.onPrimary,
                ),
              ),
            ],
          );
        });
  }
}
