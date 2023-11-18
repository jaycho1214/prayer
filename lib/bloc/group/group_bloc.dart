import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:prayer/bloc/group/group_event.dart';
import 'package:prayer/bloc/group/group_state.dart';
import 'package:prayer/repo/group_repository.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final String groupId;
  final GroupRepository groupRepository;

  GroupBloc({
    required this.groupId,
    required this.groupRepository,
  }) : super(const GroupState.idle()) {
    on<GroupEventLoad>(loadGroup);
    on<GroupEventJoin>(joinGroup);
    add(const GroupEvent.load());
  }

  Future<void> loadGroup(
    GroupEventLoad event,
    Emitter<GroupState> emit,
  ) async {
    try {
      switch (state) {
        case GroupStateLoaded(group: final group):
          emit(GroupState.refreshing(group));
        default:
      }
      final data = await this.groupRepository.fetchGroup(groupId);
      if (data == null) {
        return emit(GroupState.error("Unable to find the group"));
      }
      emit(GroupState.loaded(group: data));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data['message'] != null) {
          return emit(GroupState.error(e.response?.data['message']));
        }
      }
      emit(GroupState.error("Unknown error occured"));
    }
  }

  Future<void> joinGroup(
    GroupEventJoin event,
    Emitter<GroupState> emit,
  ) async {
    final value = event.value;
    final backup = (state as GroupStateLoaded).group;
    try {
      if (!(state is GroupStateLoaded)) {
        return;
      }
      emit(GroupState.loaded(
          group: backup.copyWith(
        joinedAt: value ? DateTime.now() : null,
        acceptedAt: value
            ? backup.membershipType == 'open'
                ? DateTime.now()
                : null
            : null,
      )));
      final data =
          await this.groupRepository.joinGroup(groupId: groupId, value: value);
      if (value) {
        if (data['data'] == null) {
          emit(GroupState.loaded(
              group: backup.copyWith(
            joinedAt: DateTime.now(),
            acceptedAt: null,
          )));
        } else {
          emit(GroupState.loaded(
              group: backup.copyWith(
            joinedAt: DateTime.now(),
            acceptedAt: DateTime.now(),
          )));
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data['message'] != null) {
          return emit(GroupState.loaded(
              group: backup, message: e.response?.data['message']));
        }
      }
      emit(GroupState.loaded(group: backup, message: "Unknown error occured"));
    }
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
