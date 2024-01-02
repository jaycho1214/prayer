import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_graph_provider.g.dart';

@riverpod
class OpenGrpahNotifier extends _$OpenGrpahNotifier {
  @override
  FutureOr<Map<String, dynamic>?> build(String? url) async {
    try {
      if (url == null) {
        return null;
      }
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
}
