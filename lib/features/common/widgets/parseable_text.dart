import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:prayer/utils/linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ParseableText extends StatelessWidget {
  const ParseableText(
    this.data, {
    Key? key,
    this.trimExpandedText = 'show less',
    this.trimCollapsedText = 'read more',
    this.colorClickableText,
    this.trimLines,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor = 1.0,
    this.delimiter = _kEllipsis + ' ',
    this.delimiterStyle,
  }) : super(key: key);

  /// Used on TrimMode.Lines
  final int? trimLines;

  final String delimiter;
  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color? colorClickableText;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final double textScaleFactor;
  final TextStyle? delimiterStyle;

  Future<void> onClickLink(
      BuildContext context, LinkableElement element) async {
    await launchUrlString(element.url);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultTextStyle = Theme.of(context).textTheme.bodyMedium ??
        DefaultTextStyle.of(context).style;
    TextStyle? effectiveTextStyle = style;

    final _textAlign =
        textAlign ?? DefaultTextStyle.of(context).textAlign ?? TextAlign.start;
    final _textDirection = textDirection ?? Directionality.of(context);
    final overflow = defaultTextStyle.overflow;
    final _defaultDelimiterStyle = delimiterStyle ?? effectiveTextStyle;

    TextSpan link = TextSpan(
      text: trimCollapsedText,
      style: Theme.of(context).textTheme.labelMedium,
    );

    TextSpan _delimiter = TextSpan(
      text: trimCollapsedText.isNotEmpty ? delimiter : '',
      style: _defaultDelimiterStyle,
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final text = TextSpan(text: data, style: effectiveTextStyle);

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: _textAlign,
          textDirection: _textDirection,
          textScaler: TextScaler.linear(textScaleFactor),
          maxLines: trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? delimiter : null,
        );
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure delimiter
        textPainter.text = _delimiter;
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final delimiterSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final readMoreSize = linkSize.width + delimiterSize.width;
          final pos = textPainter.getPositionForOffset(Offset(
            _textDirection == TextDirection.rtl
                ? readMoreSize
                : textSize.width - readMoreSize,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        final commonOptions = LinkifyOptions(
          humanize: false,
          removeWww: false,
          looseUrl: true,
          defaultToHttps: true,
          excludeLastPeriod: true,
        );
        final linkifiers = [CustomUrlLinkifier()];

        late final TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            style: effectiveTextStyle,
            children: <TextSpan>[
              LinkifySpan(
                text: data.substring(0, endIndex) +
                    (linkLongerThanLine ? _kLineSeparator : ''),
                options: commonOptions,
                linkStyle: TextStyle(
                  color: Colors.blue,
                ),
                linkifiers: linkifiers,
                onOpen: (link) => onClickLink(context, link),
              ),
              _delimiter,
              link,
            ],
          );
        } else {
          textSpan = LinkifySpan(
            style: effectiveTextStyle,
            text: data,
            options: commonOptions,
            linkStyle: TextStyle(
              color: Colors.blue,
            ),
            onOpen: (link) => onClickLink(context, link),
            linkifiers: linkifiers,
          );
        }

        return Text.rich(
          textSpan,
          textAlign: _textAlign,
          textDirection: _textDirection,
          softWrap: true,
          overflow: TextOverflow.clip,
          textScaler: TextScaler.linear(textScaleFactor),
        );
      },
    );
  }
}
