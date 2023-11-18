import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/model/group_model.dart';

part 'group_state.freezed.dart';

@freezed
sealed class GroupState with _$GroupState {
  const factory GroupState.idle() = GroupStateIdle;
  const factory GroupState.loading() = GroupStateLoading;
  const factory GroupState.loaded({
    required Group group,
    String? message,
  }) = GroupStateLoaded;
  const factory GroupState.refreshing(Group group) = GroupStateRefreshing;
  const factory GroupState.error(String message) = GroupStateError;
}
