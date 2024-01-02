import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/prayer/providers/open_graph_provider.dart';
import 'package:prayer/utils/linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OpenGraphCard extends HookConsumerWidget {
  const OpenGraphCard({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = useMemoized(() {
      final parse = CustomUrlLinkifier().parse(
        [TextElement(text)],
        LinkifyOptions(excludeLastPeriod: true, defaultToHttps: true),
      );
      if (parse.length == 0) {
        return null;
      }
      return parse.whereType<UrlElement>().firstOrNull?.url;
    }, [text]);
    final snapshot = ref.watch(openGrpahNotifierProvider(url));
    final title = snapshot.value?['og:title'] ?? snapshot.value?['title'];
    if (snapshot.valueOrNull == null || title == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ShrinkingButton(
        onTap: () => launchUrlString(url!),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: MyTheme.disabled, width: 1.0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (snapshot.value?['og:image'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: snapshot.value!['og:image'],
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.value?['og:title'] ??
                          snapshot.value?['title'] ??
                          '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    if (snapshot.value?['og:description'] != null)
                      Text(
                        snapshot.value!['og:description'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyTheme.placeholderText,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
