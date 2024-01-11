import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class Dialog extends HookWidget {
  const Dialog({
    super.key,
    required this.message,
    this.onRemove,
    this.duration = const Duration(seconds: 3),
    this.onTap,
  });

  final void Function()? onRemove;
  final void Function()? onTap;
  final String message;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final shown = useState(false);
    final progress = useState(1.0);

    final remove = useCallback(() {
      shown.value = false;
      onRemove?.call();
    }, [onRemove]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        shown.value = true;
        progress.value = 0.0;
        Future.delayed(duration, () {
          shown.value = false;
        });
      });
      return () {
        shown.value = false;
      };
    }, []);

    return AnimatedPositioned(
      left: 0,
      right: 0,
      top: shown.value ? MediaQuery.of(context).padding.top + 20 : 0,
      onEnd: () {
        if (!shown.value) {
          remove();
          onRemove?.call();
        }
      },
      duration: const Duration(milliseconds: 300),
      child: AnimatedOpacity(
        opacity: shown.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onVerticalDragStart: (dragStartDetail) {
            if (dragStartDetail.globalPosition.dy > 0) {
              shown.value = false;
            }
          },
          onTap: () {
            shown.value = false;
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 60,
            clipBehavior: Clip.hardEdge,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            message,
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.onPrimary),
                            maxLines: 2,
                          ),
                        ),
                        ShrinkingButton(
                          onTap: () {
                            shown.value = false;
                            onTap?.call();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              shape: BoxShape.circle,
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.solidChevronRight,
                              color: Theme.of(context).colorScheme.onBackground,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: AnimatedContainer(
                    duration: duration,
                    height: 2,
                    width: progress.value *
                        (MediaQuery.of(context).size.width - 20),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationSnackBar {
  static OverlayEntry? entry;

  static show(
    BuildContext context, {
    required String message,
    void Function()? onTap,
  }) {
    NotificationSnackBar.entry?.remove();
    NotificationSnackBar.entry = OverlayEntry(
      builder: (context) => Dialog(
        message: message,
        onRemove: () {
          NotificationSnackBar.entry?.remove();
          NotificationSnackBar.entry = null;
        },
        onTap: onTap,
      ),
    );
    Overlay.maybeOf(context)?.insert(NotificationSnackBar.entry!);
  }
}
