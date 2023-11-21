import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/form/text_input_form.dart';
import 'package:prayer/repo/user_repository.dart';

class UsernameInputForm extends HookWidget {
  const UsernameInputForm({
    super.key,
    this.initialValue,
  });

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final editedAt = useRef<DateTime>(DateTime.utc(9999));
    // Idle: 0, Loading: 1, Success: 2, Taken: -1, Error: -2,
    final valid = useState<int>(0);
    final username = useState<String?>('');
    final suffix = useMemoized(() {
      const size = 20.0;
      if (valid.value == 1) {
        return PlatformCircularProgressIndicator();
      } else if (valid.value == 2) {
        return const FaIcon(
          FontAwesomeIcons.solidCircleCheck,
          color: Colors.green,
          size: size,
        );
      } else if (valid.value == -1) {
        return const FaIcon(
          FontAwesomeIcons.xmark,
          color: MyTheme.error,
          size: size,
        );
      } else if (valid.value == -2) {
        return const FaIcon(
          FontAwesomeIcons.solidCircleXmark,
          color: MyTheme.error,
          size: size,
        );
      }
      return null;
    }, [valid.value]);

    final validateUsername = useCallback((String value) {
      if (!RegExp(r'^[a-zA-Z0-9._]{1,30}$').hasMatch(value)) {
        return false;
      }
      return true;
    }, []);

    useEffect(() {
      final timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
        if (DateTime.timestamp().difference(editedAt.value).inMilliseconds >
            1000) {
          editedAt.value = DateTime.utc(9999);
          final input = username.value ?? '';
          if (validateUsername(input) &&
              input.isNotEmpty &&
              initialValue != input) {
            valid.value = 1;
            GetIt.I<UserRepository>().fetchUser(username: input).then((value) {
              valid.value = value == null ? 2 : -1;
            }).catchError((error, stackTrace) {
              talker.error("Error while checking if username has already taken",
                  error, stackTrace);
              valid.value = -2;
            });
          } else {
            valid.value = 0;
          }
        }
      });
      return timer.cancel;
    }, [editedAt.value, initialValue, username.value, context]);

    return TextInputField(
      name: 'username',
      autovalidateMode: AutovalidateMode.always,
      onChanged: (newUsername) {
        valid.value = 0;
        username.value = newUsername;
        editedAt.value = DateTime.timestamp();
      },
      labelText: "Username",
      maxLength: 30,
      maxLines: 1,
      keyboardType: TextInputType.text,
      suffix: suffix,
      validator: (value) {
        if (value == null || value == '') {
          return 'Username is requried';
        }
        if (!RegExp(r'^[a-zA-Z0-9._]{1,30}$').hasMatch(value)) {
          return 'You can only use alphabets, numbers, period, and underscore for the username';
        }
        if (valid.value == -1) {
          return 'Username has already taken';
        }
        if (valid.value == -2) {
          return 'Error while checking your username';
        }
        return null;
      },
    );
  }
}
