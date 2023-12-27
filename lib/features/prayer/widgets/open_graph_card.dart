import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

final _looseUrlRegex = RegExp(
  r'''^(.*?)((https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//="'`]*))''',
  caseSensitive: false,
  dotAll: true,
);

class OpenGraphCard extends HookWidget {
  const OpenGraphCard({
    super.key,
    required this.text,
  });

  final String text;

  /// Parses OG tags from the HTML of the given URL.
  Future<Map<String, dynamic>> parseOgTags(String url) async {
    try {
      // Fetch the website content
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parse the HTML document
        var document = parser.parse(response.body);
        Map<String, dynamic> ogTags = {};

        // Find all meta tags in the document
        var metaTags = document.getElementsByTagName('meta');

        // Iterate over meta tags to find OG tags
        for (var tag in metaTags) {
          if (tag.attributes['property'] != null &&
              tag.attributes['property']!.startsWith('og:')) {
            // Extract the property and content values and add them to the map
            String property = tag.attributes['property']!;
            String? content = tag.attributes['content'];
            if (content != null) {
              ogTags[property] = content;
            }
          }
        }
        return ogTags; // Return the map of OG tags
      } else {
        // Handle non-successful responses
        throw Exception('Failed to load website');
      }
    } catch (e) {
      // Handle any other type of error
      throw Exception('Failed to parse OG tags: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final url = useMemoized(() {
      final match = _looseUrlRegex.firstMatch(text);
      if (match == null) {
        return null;
      }
      if (match.group(1)?.isNotEmpty == true) {
        return match.group(1)!;
      } else if (match.group(2)?.isNotEmpty == true) {
        var originalUrl = match.group(2)!;

        if (originalUrl[originalUrl.length - 1] == ".") {
          return originalUrl.substring(0, originalUrl.length - 1);
        }
        return originalUrl;
      }
      return null;
    }, [text]);
    if (url == null) {
      return const SizedBox();
    }
    final snapshot = useFuture(useMemoized(() => parseOgTags(url), [url]));
    if (snapshot.data == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ShrinkingButton(
        onTap: () => launchUrlString(url),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: MyTheme.disabled, width: 1.0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (snapshot.data?['og:image'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: snapshot.data!['og:image'],
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
                      snapshot.data!['og:title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    if (snapshot.data?['og:description'] != null)
                      Text(
                        snapshot.data!['og:description'],
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
