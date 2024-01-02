import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:prayer/utils/linkify.dart';

class RichTextController extends TextEditingController {
  RichTextController({
    super.text,
    this.onOpen,
  });

  final dynamic Function(LinkableElement)? onOpen;

  LinkifySpan buildLinkify(String text, {TextStyle? style}) {
    return LinkifySpan(
      text: text,
      style: style,
      options: LinkifyOptions(
        humanize: true,
        removeWww: false,
        looseUrl: true,
        excludeLastPeriod: true,
      ),
      spellOut: true,
      linkStyle: TextStyle(
        color: Colors.blue,
      ),
      onOpen: onOpen,
      linkifiers: [const CustomUrlLinkifier()],
    );
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    assert(!value.composing.isValid ||
        !withComposing ||
        value.isComposingRangeValid);
    // If the composing range is out of range for the current text, ignore it to
    // preserve the tree integrity, otherwise in release mode a RangeError will
    // be thrown and this EditableText will be built with a broken subtree.
    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      return buildLinkify(text, style: style);
    }

    final TextStyle composingStyle =
        style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
            const TextStyle(decoration: TextDecoration.underline);

    return TextSpan(
      style: style,
      children: <TextSpan>[
        buildLinkify(value.composing.textBefore(value.text)),
        buildLinkify(value.composing.textInside(value.text),
            style: composingStyle),
        buildLinkify(value.composing.textAfter(value.text)),
      ],
    );
  }
}

RichTextController useRichTextController({
  void Function(LinkableElement)? onOpen,
}) {
  return use(_RichTextControllerHook(
    onOpen: onOpen,
  ));
}

class _RichTextControllerHook extends Hook<RichTextController> {
  const _RichTextControllerHook({
    this.onOpen = null,
  });

  final Function(LinkableElement)? onOpen;

  @override
  _RichTextControllerHookState createState() => _RichTextControllerHookState();
}

class _RichTextControllerHookState
    extends HookState<RichTextController, _RichTextControllerHook> {
  late final RichTextController _controller =
      RichTextController(onOpen: hook.onOpen);

  @override
  RichTextController build(BuildContext context) => _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
