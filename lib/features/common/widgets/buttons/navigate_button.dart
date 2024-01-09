import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

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
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}

class NavigateBackButton extends StatelessWidget {
  const NavigateBackButton({
    super.key,
    this.result,
    this.onPressed,
  });

  final void Function()? onPressed;
  final dynamic result;

  @override
  Widget build(BuildContext context) {
    return NavigateIconButton(
      icon: FontAwesomeIcons.solidChevronLeft,
      onPressed: onPressed ?? () => context.pop(result),
    );
  }
}
