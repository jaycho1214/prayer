import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';

class NavigateIconButton extends StatelessWidget {
  const NavigateIconButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      onPressed: onPressed,
      icon: FaIcon(
        icon,
        size: 15,
        color: MyTheme.onPrimary,
      ),
    );
  }
}

class NavigateBackButton extends StatelessWidget {
  const NavigateBackButton({
    super.key,
    this.result,
  });

  final dynamic result;

  @override
  Widget build(BuildContext context) {
    return NavigateIconButton(
      icon: FontAwesomeIcons.solidChevronLeft,
      onPressed: () => context.pop(result),
    );
  }
}
