import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/group/group_model.dart';
import 'package:prayer/features/group/widgets/group_search_screen.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class GroupPicker extends HookWidget {
  const GroupPicker({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: MyTheme.sheetSurface,
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => GroupPicker(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pagingController =
        usePagingController<String?, Group>(firstPageKey: null);
    return DraggableScrollableSheet(
      snap: true,
      snapSizes: [0.5, 1],
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: MyTheme.sheetSurface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              S.of(context).chooseGroup,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ShrinkingButton(
                onTap: () => Navigator.of(context).pop(''),
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
                        S.of(context).community,
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
              child: GroupSearchScreen(
                pagingController: pagingController,
                uid: FirebaseAuth.instance.currentUser!.uid,
                scrollController: scrollController,
                onTap: (item) => Navigator.of(context).pop(item),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
