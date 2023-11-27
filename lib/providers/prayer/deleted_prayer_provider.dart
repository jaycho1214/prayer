import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deleted_prayer_provider.g.dart';

@riverpod
class DeletedPrayerNotifier extends _$DeletedPrayerNotifier {
  @override
  List<String> build() {
    return <String>[];
  }

  void add(String prayerId) {
    state = [...state, prayerId];
  }
}
