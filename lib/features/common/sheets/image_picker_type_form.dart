import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/i18n/strings.g.dart';

enum ImagePickTypeMenuType {
  pick,
  delete,
  reset,
}

class ImagePickTypeForm extends StatelessWidget {
  const ImagePickTypeForm({
    super.key,
    this.onTap,
    this.initialValue,
  });

  final void Function(ImagePickTypeMenuType menu)? onTap;
  final dynamic initialValue;

  static show(BuildContext context,
      {void Function(ImagePickTypeMenuType menu)? onTap,
      dynamic initialValue}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ImagePickTypeForm(
        onTap: onTap,
        initialValue: initialValue,
      ),
    );
  }

  Widget _renderRow({
    required IconData icon,
    required String text,
    Color? color,
    EdgeInsets margin = EdgeInsets.zero,
    EdgeInsets padding = EdgeInsets.zero,
    void Function()? onTap,
  }) {
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              color: color,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 10, 0,
          MediaQuery.of(context).padding.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderRow(
            text: t.alert.imagePicker.pickImageFromGallery,
            icon: FontAwesomeIcons.photoFilm,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            onTap: () {
              Navigator.pop(context);
              onTap?.call(ImagePickTypeMenuType.pick);
            },
          ),
          const Divider(),
          if (initialValue != null) ...[
            _renderRow(
              text: t.alert.imagePicker.resetToDefault,
              icon: FontAwesomeIcons.rotateLeft,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              onTap: () {
                Navigator.pop(context);
                onTap?.call(ImagePickTypeMenuType.reset);
              },
            ),
            const Divider(),
          ],
          _renderRow(
              text: t.alert.imagePicker.removeCurrentPhoto,
              icon: FontAwesomeIcons.trash,
              color: Theme.of(context).colorScheme.error,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              onTap: () {
                Navigator.pop(context);
                onTap?.call(ImagePickTypeMenuType.delete);
              }),
        ],
      ),
    );
  }
}
