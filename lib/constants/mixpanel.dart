import 'package:flutter/material.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

late final Mixpanel mixpanel;

class MixpanelNavigatorObserver extends NavigatorObserver {
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    mixpanel.track('Page Visited', properties: {
      'name': route.settings.name,
      'arguments': route.settings.arguments,
    });
  }

  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    mixpanel.track('Page Visited', properties: {
      'name': route.settings.name,
      'arguments': route.settings.arguments,
    });
  }
}
