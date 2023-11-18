import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_event.freezed.dart';

@freezed
sealed class GroupEvent with _$GroupEvent {
  const factory GroupEvent.load() = GroupEventLoad;
  const factory GroupEvent.join(bool value) = GroupEventJoin;
}
