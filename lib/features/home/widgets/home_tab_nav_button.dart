import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class HomeTabNavButton extends StatelessWidget {
  const HomeTabNavButton({
    super.key,
    this.onTap,
    required this.focusedIcon,
    required this.unfocusedIcon,
    this.focused = false,
  });

  final IconData focusedIcon;
  final IconData unfocusedIcon;
  final bool focused;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FaIcon(
          focused ? focusedIcon : unfocusedIcon,
          size: 20,
          color: focused
              ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              : Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}

class HomeTabNavProfileButton extends StatelessWidget {
  const HomeTabNavProfileButton({
    super.key,
    this.profile,
    this.onTap,
    this.focused = false,
  });

  final String? profile;
  final bool focused;
  final void Function()? onTap;
  final double size = 20;

  Widget _renderPlaceholder(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: FaIcon(
        FontAwesomeIcons.user,
        size: 12,
        color: focused
            ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
            : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
      ),
    );
  }

  Widget buildInnerContainer(BuildContext context) {
    return profile == null
        ? _renderPlaceholder(context)
        : CachedNetworkImage(
            width: size,
            height: size,
            imageUrl: profile!,
            errorWidget: (context, url, error) => Center(
              child: _renderPlaceholder(context),
            ),
            imageBuilder: (context, imageProvider) => Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  )),
            ),
          );
  }

  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        alignment: Alignment.topCenter,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: focused
                  ? Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor!
                  : Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor!,
              width: focused ? 1 : 0.5,
            ),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(2),
          child: buildInnerContainer(context),
        ),
      ),
    );
  }
}
