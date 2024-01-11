import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class ImageGalleryScreen extends HookWidget {
  const ImageGalleryScreen({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    final controller = useTransformationController();
    final value = useState<Offset?>(null);
    return GestureDetector(
      onDoubleTapDown: (details) {
        value.value = details.localPosition;
      },
      onDoubleTap: () {
        if (controller.value.getMaxScaleOnAxis() > 1.5) {
          controller.value = Matrix4.identity();
        } else {
          controller.value = Matrix4.identity()
            ..translate(-value.value!.dx * 1, -value.value!.dy * 1)
            ..scale(2.0);
        }
      },
      child: Stack(
        children: [
          SizedBox.expand(
            child: InteractiveViewer(
              transformationController: controller,
              minScale: 0.5,
              maxScale: 5.0,
              child: CachedNetworkImage(
                imageUrl: url,
                errorWidget: (context, url, error) => Center(
                  child: Text(t.error.loadImage),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 30,
            child: ShrinkingButton(
              onTap: () => context.pop(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.2),
                    child: FaIcon(
                      FontAwesomeIcons.xmark,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
