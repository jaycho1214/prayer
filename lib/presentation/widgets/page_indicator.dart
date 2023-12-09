import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/utils/utils.dart';

class PageIndicator extends HookWidget {
  const PageIndicator({
    super.key,
    required this.itemCount,
    required this.controller,
  });

  final int itemCount;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final index = useState(0.0);

    final onAction = useCallback(() {
      index.value = controller.page ?? 0.0;
    }, []);

    useEffect(() {
      controller.addListener(onAction);
      return () => controller.removeListener(onAction);
    }, []);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (i) => HookBuilder(
          builder: (context) {
            final size = Utils.interpolate(
                index.value, [i - 1, i.toDouble(), i + 1], [5, 10, 5]);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Utils.interpolateColor(index.value, [
                  i - 1,
                  i.toDouble(),
                  i + 1
                ], [
                  MyTheme.disabled,
                  MyTheme.onPrimary,
                  MyTheme.disabled,
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
