import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

class FAB extends StatelessWidget {
  const FAB({
    super.key,
    required this.onTap,
    this.loading = false,
  });

  final bool loading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: MediaQuery.of(context).padding.bottom + 20,
      child: ShrinkingButton(
        onTap: onTap,
        child: Container(
          height: 63,
          width: 63,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: MyTheme.fab,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: loading
                ? CircularProgressIndicator.adaptive(
                    strokeWidth: 2.0,
                  )
                : FaIcon(FontAwesomeIcons.plus),
          ),
        ),
      ),
    );
  }
}
