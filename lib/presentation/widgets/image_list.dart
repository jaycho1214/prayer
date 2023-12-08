import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InnerImageCard extends HookWidget {
  const InnerImageCard({
    super.key,
    required this.image,
    required this.borderRadius,
  });

  final String image;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final onTap = useCallback(
        (String path) => () {
              context.push(Uri(path: '/image', queryParameters: {
                'imageUrl': path,
              }).toString());
            },
        []);

    return ShrinkingButton(
      onTap: onTap(image),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
        child: Hero(
          tag: image,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            placeholder: (context, url) => Skeletonizer(
              enabled: true,
              child: SizedBox.expand(),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageList extends HookWidget {
  const ImageList({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.length == 0) {
      return SizedBox();
    } else if (images.length == 1) {
      return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.width - 80),
        child: InnerImageCard(
          image: images.first,
          borderRadius: BorderRadius.circular(10),
        ),
      );
    } else if (images.length == 2) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: (MediaQuery.of(context).size.width - 60) / 2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: images
              .asMap()
              .entries
              .map(
                (image) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: image.key != 0 ? 1 : 0,
                      right: image.key != 0 ? 0 : 1,
                    ),
                    child: InnerImageCard(
                      image: image.value,
                      borderRadius: BorderRadius.horizontal(
                        left:
                            image.key != 0 ? Radius.zero : Radius.circular(10),
                        right:
                            image.key == 0 ? Radius.zero : Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    } else if (images.length == 3) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: (MediaQuery.of(context).size.width - 60) / 2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InnerImageCard(
                image: images.first,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: InnerImageCard(
                      image: images[1],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: InnerImageCard(
                      image: images[2],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (images.length == 4) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: (MediaQuery.of(context).size.width - 60) / 1.5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: InnerImageCard(
                      image: images[0],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: InnerImageCard(
                      image: images[2],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: InnerImageCard(
                      image: images[1],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: InnerImageCard(
                      image: images[3],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
