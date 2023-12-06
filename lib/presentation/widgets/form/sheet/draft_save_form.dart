import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

class DraftSaveForm extends StatelessWidget {
  const DraftSaveForm({
    super.key,
  });

  static show(
    BuildContext context,
  ) {
    showModalBottomSheet(
      backgroundColor: MyTheme.sheetSurface,
      context: context,
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => DraftSaveForm(),
    );
  }

  Widget _renderRow({
    required IconData icon,
    required String text,
    Color color = MyTheme.onPrimary,
    EdgeInsets margin = EdgeInsets.zero,
    EdgeInsets padding = EdgeInsets.zero,
    void Function()? onTap,
  }) {
    return Expanded(
      child: ShrinkingButton(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 10,
            0, MediaQuery.of(context).padding.bottom + 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _renderRow(
              text: S.of(context).pickImageFromGallery,
              icon: FontAwesomeIcons.photoFilm,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(color: MyTheme.outline),
            _renderRow(
                text: S.of(context).removeCurrentPhoto,
                icon: FontAwesomeIcons.trash,
                color: MyTheme.error,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
