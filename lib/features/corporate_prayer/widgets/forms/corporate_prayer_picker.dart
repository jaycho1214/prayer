import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/features/corporate_prayer/widgets/group_corporate_prayers_screen.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class CorporatePrayerPicker extends HookWidget {
  const CorporatePrayerPicker({
    super.key,
    required this.groupId,
  });

  final String groupId;

  static Future<String?> show(
    BuildContext context, {
    required String groupId,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: MyTheme.sheetSurface,
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => CorporatePrayerPicker(
        groupId: groupId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pagingController =
        usePagingController<String?, String>(firstPageKey: null);

    return DraggableScrollableSheet(
      snap: true,
      snapSizes: [0.5, 1],
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          const SizedBox(height: 20),
          Text(
            S.of(context).chooseCorporatePrayer,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ShrinkingButton(
              onTap: () => Navigator.of(context).pop(null),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: MyTheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.lightGlobe,
                        color: MyTheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      S.of(context).group,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(color: MyTheme.outline),
          Expanded(
            child: GroupCorporatePrayersScreen(
              noItemsFoundIndicatorBuilder: (p0) => const SizedBox(),
              groupId: groupId,
              pagingController: pagingController,
              scrollController: scrollController,
              onTap: (item) => Navigator.of(context).pop(item),
            ),
          ),
        ],
      ),
    );
  }
}
