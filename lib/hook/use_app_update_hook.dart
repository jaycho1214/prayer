import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/common/sheets/need_app_update_sheet.dart';

void useAppUpdate(BuildContext context) {
  final fn = useCallback(() async {
    try {
      await FirebaseRemoteConfig.instance.fetchAndActivate();
      final minimumVersion =
          FirebaseRemoteConfig.instance.getString("minimum_version");
      talker.debug(
          "[FirebaseRemoteConfig] minimum version fetched: $minimumVersion");
      if (minimumVersion == "") {
        return () => null;
      }
      final version = jsonDecode(minimumVersion);
      talker.good("[FirebaseRemoteConfig] minimum version: $version");
      final package = await PackageInfo.fromPlatform();
      bool activate = false;
      if (Platform.isAndroid &&
          version['android'] > int.tryParse(package.buildNumber)) {
        activate = true;
      } else if (Platform.isIOS &&
          (version['ios'] as String)
                  .compareTo('${package.version}+${package.buildNumber}') >
              0) {
        activate = true;
      }
      if (activate) {
        NeedAppUpdateSheet.show(context);
      }
    } catch (e, st) {
      talker.error(
          "[FirebaseRemoteConfig] Error while fetching minimum verision",
          e,
          st);
    }
    return () => null;
  }, []);

  useEffect(() {
    fn();
    return () => null;
  }, []);
}
