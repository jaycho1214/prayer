import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer/utils/app_link.dart';

void useAppLink(BuildContext context) {
  useEffect(() {
    AppLinks().getInitialAppLink().then((uri) {
      if (uri == null) {
        return;
      }
      handleAppLink(context, uri);
    });
    return () => null;
  }, []);

  useEffect(() {
    final subscription = AppLinks()
        .allUriLinkStream
        .listen((uri) => handleAppLink(context, uri));
    return () => subscription.cancel();
  }, []);
}
