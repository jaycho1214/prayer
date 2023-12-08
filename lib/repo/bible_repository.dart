import 'package:prayer/constants/dio.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';

class BibleRepository {
  Future<BibleVerse?> fetchVerse(int verseId, {int? translationId}) async {
    final resp = await dio.get('/v1/bibles/verses/$verseId',
        queryParameters: {'translationId': translationId});
    if (resp.data['message'] != null) {
      throw resp.data['message'];
    }
    final group = resp.data['data'] == null
        ? null
        : BibleVerse.fromJson(resp.data['data']);
    return group;
  }
}
