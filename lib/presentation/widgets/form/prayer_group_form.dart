import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/presentation/widgets/form/sheet/group_picker.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrayerGroupForm extends HookWidget {
  const PrayerGroupForm({
    super.key,
    this.onChange,
  });

  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'groupId',
      builder: (FormFieldState<String> field) => PlayerGroupFormInner(
        groupId: field.value,
        onChange: (groupId) {
          field.didChange(groupId);
          onChange?.call(groupId);
        },
      ),
    );
  }
}

class PlayerGroupFormInner extends HookWidget {
  const PlayerGroupFormInner({super.key, this.groupId, this.onChange});

  final String? groupId;
  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    final fetchFn = useMemoized(
        () => groupId == null
            ? null
            : GetIt.I<GroupRepository>().fetchGroup(groupId!),
        [groupId]);
    final snapshot = useFuture(fetchFn, initialData: Group.placeholder);

    useEffect(() {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data == null) {
        onChange?.call(null);
      }
      return () => null;
    }, [snapshot, onChange]);

    return Skeletonizer(
      enabled: snapshot.connectionState == ConnectionState.waiting,
      child: ShrinkingButton(
        onTap: () async {
          final groupId = await GroupPicker.show(context);
          onChange?.call(groupId);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MyTheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Text(
                groupId == null ? 'Community' : snapshot.data?.name ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(width: 5),
              FaIcon(
                FontAwesomeIcons.chevronDown,
                color: MyTheme.onPrimary,
                size: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
