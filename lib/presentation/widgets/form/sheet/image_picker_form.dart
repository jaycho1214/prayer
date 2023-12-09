import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ImagePickerProvider extends ChangeNotifier {
  List<String> _selected = [];
  List<String> get selected => _selected;

  void add(String id) {
    _selected.add(id);
    notifyListeners();
  }

  void remove(String id) {
    _selected.remove(id);
    notifyListeners();
  }

  void set(List<String> newIds) {
    _selected = newIds;
    notifyListeners();
  }

  void reset() {
    _selected.clear();
    notifyListeners();
  }
}

final imagePickerProvider =
    ChangeNotifierProvider((ref) => ImagePickerProvider());

class InnerImageCard extends ConsumerWidget {
  const InnerImageCard({
    super.key,
    required this.imageId,
    required this.image,
    this.onTap,
    this.maxLength,
  });

  final int? maxLength;
  final String imageId;
  final AssetEntity? image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(imagePickerProvider);

    return ShrinkingButton(
      onTap: onTap,
      child: Stack(
        children: [
          image == null
              ? SizedBox()
              : Image(
                  image: AssetEntityImageProvider(
                    image!,
                    isOriginal: false,
                    thumbnailSize: ThumbnailSize.square(200),
                  ),
                  height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
          Positioned(
            right: 5,
            top: 5,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54,
                border: Border.all(
                  color: MyTheme.onPrimary,
                ),
              ),
            ),
          ),
          if (provider.selected.contains(imageId))
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(color: Colors.green),
                  ),
                ),
                Positioned(
                  right: 7.5,
                  top: 7.5,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyTheme.primary,
                    ),
                    child: Center(
                      child: Text(
                        '${provider.selected.indexOf(imageId) + 1}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (maxLength != null &&
              provider.selected.length == maxLength &&
              !provider.selected.contains(imageId))
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
            ),
        ],
      ),
    );
  }
}

class InnerImagePicker extends HookConsumerWidget {
  const InnerImagePicker({
    super.key,
    this.maxLength,
    this.initialIds,
  });

  final int? maxLength;
  final List<String>? initialIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPermission = useState<bool?>(null);
    final pagingController =
        usePagingController<int, AssetEntity>(firstPageKey: 0);

    final onTap = useCallback(
        (String id) => () async {
              final provider = ref.read(imagePickerProvider);
              if (provider.selected.contains(id)) {
                ref.read(imagePickerProvider).remove(id);
              } else {
                if (maxLength != null) {
                  if (provider.selected.length >= maxLength!) {
                    return () => null;
                  }
                  if (maxLength == 1) {
                    final asset = await AssetEntity.fromId(id);
                    if (asset != null) {
                      context.pop([asset]);
                    }
                  }
                }
                ref.read(imagePickerProvider).add(id);
              }
              return () => null;
            },
        [context]);

    final fetchPage = useCallback((int? cursor) async {
      final data = await PhotoManager.getAssetListPaged(
        page: cursor ?? 0,
        pageCount: 80,
        type: RequestType.image,
      );
      if (data.length == 80) {
        pagingController.appendPage(data, (cursor ?? 0) + 1);
      } else {
        pagingController.appendLastPage(data);
      }
    }, []);

    useEffect(() {
      pagingController.addPageRequestListener(fetchPage);
      PhotoManager.requestPermissionExtend().then((value) {
        hasPermission.value = value.hasAccess;
      });
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(imagePickerProvider).reset();
        if (initialIds != null) {
          ref.read(imagePickerProvider).set(initialIds!);
        }
      });
      return () => pagingController.removePageRequestListener(fetchPage);
    }, []);

    if (hasPermission.value == false) {
      return SizedBox(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        child: Column(children: [
          Text(S.of(context).errorAccessPhoto),
          const SizedBox(height: 10),
          PrimaryTextButton(
            text: S.of(context).accept,
            onTap: () => PhotoManager.openSetting(),
          ),
        ]),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top,
      child: PagedGridView(
        pagingController: pagingController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: MediaQuery.of(context).size.width / 3,
          crossAxisCount: 3,
        ),
        builderDelegate: PagedChildBuilderDelegate<AssetEntity>(
          itemBuilder: (context, item, index) => InnerImageCard(
            imageId: item.id,
            image: item,
            onTap: onTap(item.id),
            maxLength: maxLength,
          ),
        ),
      ),
    );
  }
}

class PrimaryImagePicker {
  static WoltModalSheetPage page(
    BuildContext modalSheetContext, {
    int? maxLength,
    List<String>? initialIds,
  }) {
    return WoltModalSheetPage.withSingleChild(
      topBarTitle: Text(
        S.of(modalSheetContext).pickImage,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      leadingNavBarWidget: Container(
        margin: const EdgeInsets.only(left: 20),
        child: UnconstrainedBox(
          child: PrimaryTextButton(
            text: S.of(modalSheetContext).cancel,
            onTap: () => modalSheetContext.pop(null),
          ),
        ),
      ),
      trailingNavBarWidget: Container(
        margin: const EdgeInsets.only(right: 20),
        child: UnconstrainedBox(
          child: Consumer(
            builder: (context, ref, _) {
              return PrimaryTextButton(
                text: S.of(modalSheetContext).done,
                onTap: () async {
                  final selected = ref.read(imagePickerProvider).selected;
                  if (selected.length == 0) {
                    return context.pop(null);
                  }
                  final assets = await Future.wait(
                      selected.map((e) => AssetEntity.fromId(e)));
                  final filteredAssets = List<AssetEntity>.from(
                      assets.where((element) => element != null));
                  context.pop(filteredAssets);
                },
              );
            },
          ),
        ),
      ),
      child: InnerImagePicker(
        maxLength: maxLength,
        initialIds: initialIds,
      ),
      isTopBarLayerAlwaysVisible: true,
    );
  }

  static Future<List<AssetEntity>?> show(BuildContext context,
      {int? maxLength, List<String>? initialIds}) {
    return WoltModalSheet.show<List<AssetEntity>>(
      context: context,
      pageListBuilder: (modalSheetContext) => [
        page(
          modalSheetContext,
          maxLength: maxLength,
          initialIds: initialIds,
        )
      ],
      onModalDismissedWithBarrierTap: () {
        Navigator.of(context).pop(null);
      },
      useSafeArea: true,
      modalTypeBuilder: (_) => WoltModalType.bottomSheet,
      minPageHeight: 1.0,
      maxPageHeight: 1.0,
    );
  }
}
