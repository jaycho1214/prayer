import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';

class Dialog extends HookWidget {
  const Dialog({
    super.key,
    required this.message,
    this.onRemove,
    this.duration = const Duration(seconds: 2),
  });

  final void Function()? onRemove;
  final String message;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final shown = useState(false);

    final remove = useCallback(() {
      shown.value = false;
      onRemove?.call();
    }, [onRemove]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        shown.value = true;
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
      bottom: shown.value
          ? MediaQuery.of(context).viewInsets.bottom +
              MediaQuery.of(context).padding.bottom +
              20
          : MediaQuery.of(context).viewInsets.bottom,
      onEnd: () {
        if (!shown.value) {
          remove();
        }
      },
      duration: const Duration(milliseconds: 300),
      child: AnimatedOpacity(
        opacity: shown.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onVerticalDragStart: (dragStartDetail) {
            if (dragStartDetail.globalPosition.dy < 0) {
              shown.value = false;
            }
          },
          onTap: () {
            shown.value = false;
          },
          child: Container(
            decoration: BoxDecoration(
              color: MyTheme.inverseSurface,
              borderRadius: BorderRadius.circular(100),
            ),
            height: 70,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FaIcon(
                  FontAwesomeIcons.circleExclamation,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
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

class GlobalSnackBar {
  static OverlayEntry? entry;

  static show(
    BuildContext context, {
    required String message,
  }) {
    GlobalSnackBar.entry?.remove();
    GlobalSnackBar.entry = OverlayEntry(
      builder: (context) => Dialog(
        message: message,
        onRemove: () {
          GlobalSnackBar.entry?.remove();
          GlobalSnackBar.entry = null;
        },
      ),
    );
    Overlay.maybeOf(context)?.insert(GlobalSnackBar.entry!);
  }
}
