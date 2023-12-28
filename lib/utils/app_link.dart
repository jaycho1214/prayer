import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/talker.dart';

void handleAppLink(BuildContext context, Uri uri) {
  talker.debug("[AppLink] App link detected: ${uri.toString()}");
  final match = RegExp(r'/groups/([a-f0-9\-]{36})$').firstMatch(uri.toString());
  final groupId = match?.group(1);
  if (groupId != null) {
    context.push('/groups/$groupId');
  }
}
