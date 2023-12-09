import 'package:flutter/material.dart';

enum BibleBook {
  genesis,
  exodus,
  leviticus,
  numbers,
  deuteronomy,
  joshua,
  judges,
  ruth,
  firstSamuel,
  secondSamuel,
  firstKings,
  secondKings,
  firstChronicles,
  secondChronicles,
  ezra,
  nehemiah,
  esther,
  job,
  psalms,
  proverbs,
  ecclesiastes,
  songOfSongs,
  isaiah,
  jeremiah,
  lamentations,
  ezekiel,
  daniel,
  hosea,
  joel,
  amos,
  obadiah,
  jonah,
  micah,
  nahum,
  habakkuk,
  zephaniah,
  haggai,
  zechariah,
  malachi,
  matthew,
  mark,
  luke,
  john,
  acts,
  romans,
  firstCorinthians,
  secondCorinthians,
  galatians,
  ephesians,
  philippians,
  colossians,
  firstThessalonians,
  secondThessalonians,
  firstTimothy,
  secondTimothy,
  titus,
  philemon,
  hebrews,
  james,
  firstPeter,
  secondPeter,
  firstJohn,
  secondJohn,
  thirdJohn,
  jude,
  revelation
}

final List<Map<String, dynamic>> bible_books = [
  {
    'name': 'Genesis',
    'abbreviation': 'Gen',
    'page': 50,
    'key': BibleBook.genesis
  },
  {'name': 'Exodus', 'abbreviation': 'Ex', 'page': 40, 'key': BibleBook.exodus},
  {
    'name': 'Leviticus',
    'abbreviation': 'Lev',
    'page': 27,
    'key': BibleBook.leviticus
  },
  {
    'name': 'Numbers',
    'abbreviation': 'Num',
    'page': 36,
    'key': BibleBook.numbers
  },
  {
    'name': 'Deuteronomy',
    'abbreviation': 'Deut',
    'page': 34,
    'key': BibleBook.deuteronomy
  },
  {
    'name': 'Joshua',
    'abbreviation': 'Josh',
    'page': 24,
    'key': BibleBook.joshua
  },
  {
    'name': 'Judges',
    'abbreviation': 'Judg',
    'page': 21,
    'key': BibleBook.judges
  },
  {'name': 'Ruth', 'abbreviation': 'Ruth', 'page': 4, 'key': BibleBook.ruth},
  {
    'name': '1 Samuel',
    'abbreviation': '1 Sam',
    'page': 31,
    'key': BibleBook.firstSamuel
  },
  {
    'name': '2 Samuel',
    'abbreviation': '2 Sam',
    'page': 24,
    'key': BibleBook.secondSamuel
  },
  {
    'name': '1 Kings',
    'abbreviation': '1 Kgs',
    'page': 22,
    'key': BibleBook.firstKings
  },
  {
    'name': '2 Kings',
    'abbreviation': '2 Kgs',
    'page': 25,
    'key': BibleBook.secondKings
  },
  {
    'name': '1 Chronicles',
    'abbreviation': '1 Chr',
    'page': 29,
    'key': BibleBook.firstChronicles
  },
  {
    'name': '2 Chronicles',
    'abbreviation': '2 Chr',
    'page': 36,
    'key': BibleBook.secondChronicles
  },
  {'name': 'Ezra', 'abbreviation': 'Ezra', 'page': 10, 'key': BibleBook.ezra},
  {
    'name': 'Nehemiah',
    'abbreviation': 'Neh',
    'page': 13,
    'key': BibleBook.nehemiah
  },
  {
    'name': 'Esther',
    'abbreviation': 'Esth',
    'page': 10,
    'key': BibleBook.esther
  },
  {'name': 'Job', 'abbreviation': 'Job', 'page': 42, 'key': BibleBook.job},
  {
    'name': 'Psalms',
    'abbreviation': 'Ps',
    'page': 150,
    'key': BibleBook.psalms
  },
  {
    'name': 'Proverbs',
    'abbreviation': 'Prov',
    'page': 31,
    'key': BibleBook.proverbs
  },
  {
    'name': 'Ecclesiastes',
    'abbreviation': 'Eccl',
    'page': 12,
    'key': BibleBook.ecclesiastes
  },
  {
    'name': 'Song of Songs',
    'abbreviation': 'Song',
    'page': 8,
    'key': BibleBook.songOfSongs
  },
  {
    'name': 'Isaiah',
    'abbreviation': 'Isa',
    'page': 66,
    'key': BibleBook.isaiah
  },
  {
    'name': 'Jeremiah',
    'abbreviation': 'Jer',
    'page': 52,
    'key': BibleBook.jeremiah
  },
  {
    'name': 'Lamentations',
    'abbreviation': 'Lam',
    'page': 5,
    'key': BibleBook.lamentations
  },
  {
    'name': 'Ezekiel',
    'abbreviation': 'Ezek',
    'page': 48,
    'key': BibleBook.ezekiel
  },
  {
    'name': 'Daniel',
    'abbreviation': 'Dan',
    'page': 12,
    'key': BibleBook.daniel
  },
  {'name': 'Hosea', 'abbreviation': 'Hos', 'page': 14, 'key': BibleBook.hosea},
  {'name': 'Joel', 'abbreviation': 'Joel', 'page': 3, 'key': BibleBook.joel},
  {'name': 'Amos', 'abbreviation': 'Amos', 'page': 9, 'key': BibleBook.amos},
  {
    'name': 'Obadiah',
    'abbreviation': 'Obad',
    'page': 1,
    'key': BibleBook.obadiah
  },
  {'name': 'Jonah', 'abbreviation': 'Jonah', 'page': 4, 'key': BibleBook.jonah},
  {'name': 'Micah', 'abbreviation': 'Mic', 'page': 7, 'key': BibleBook.micah},
  {'name': 'Nahum', 'abbreviation': 'Nah', 'page': 3, 'key': BibleBook.nahum},
  {
    'name': 'Habakkuk',
    'abbreviation': 'Hab',
    'page': 3,
    'key': BibleBook.habakkuk
  },
  {
    'name': 'Zephaniah',
    'abbreviation': 'Zeph',
    'page': 3,
    'key': BibleBook.zephaniah
  },
  {'name': 'Haggai', 'abbreviation': 'Hag', 'page': 2, 'key': BibleBook.haggai},
  {
    'name': 'Zechariah',
    'abbreviation': 'Zech',
    'page': 14,
    'key': BibleBook.zechariah
  },
  {
    'name': 'Malachi',
    'abbreviation': 'Mal',
    'page': 4,
    'key': BibleBook.malachi
  },
  {
    'name': 'Matthew',
    'abbreviation': 'Matt',
    'page': 28,
    'key': BibleBook.matthew
  },
  {'name': 'Mark', 'abbreviation': 'Mark', 'page': 16, 'key': BibleBook.mark},
  {'name': 'Luke', 'abbreviation': 'Luke', 'page': 24, 'key': BibleBook.luke},
  {'name': 'John', 'abbreviation': 'John', 'page': 21, 'key': BibleBook.john},
  {'name': 'Acts', 'abbreviation': 'Acts', 'page': 28, 'key': BibleBook.acts},
  {
    'name': 'Romans',
    'abbreviation': 'Rom',
    'page': 16,
    'key': BibleBook.romans
  },
  {
    'name': '1 Corinthians',
    'abbreviation': '1 Cor',
    'page': 16,
    'key': BibleBook.firstCorinthians
  },
  {
    'name': '2 Corinthians',
    'abbreviation': '2 Cor',
    'page': 13,
    'key': BibleBook.secondCorinthians
  },
  {
    'name': 'Galatians',
    'abbreviation': 'Gal',
    'page': 6,
    'key': BibleBook.galatians
  },
  {
    'name': 'Ephesians',
    'abbreviation': 'Eph',
    'page': 6,
    'key': BibleBook.ephesians
  },
  {
    'name': 'Philippians',
    'abbreviation': 'Phil',
    'page': 4,
    'key': BibleBook.philippians
  },
  {
    'name': 'Colossians',
    'abbreviation': 'Col',
    'page': 4,
    'key': BibleBook.colossians
  },
  {
    'name': '1 Thessalonians',
    'abbreviation': '1 Thess',
    'page': 5,
    'key': BibleBook.firstThessalonians
  },
  {
    'name': '2 Thessalonians',
    'abbreviation': '2 Thess',
    'page': 3,
    'key': BibleBook.secondThessalonians
  },
  {
    'name': '1 Timothy',
    'abbreviation': '1 Tim',
    'page': 6,
    'key': BibleBook.firstTimothy
  },
  {
    'name': '2 Timothy',
    'abbreviation': '2 Tim',
    'page': 4,
    'key': BibleBook.secondTimothy
  },
  {'name': 'Titus', 'abbreviation': 'Titus', 'page': 3, 'key': BibleBook.titus},
  {
    'name': 'Philemon',
    'abbreviation': 'Phlm',
    'page': 1,
    'key': BibleBook.philemon
  },
  {
    'name': 'Hebrews',
    'abbreviation': 'Heb',
    'page': 13,
    'key': BibleBook.hebrews
  },
  {'name': 'James', 'abbreviation': 'Jas', 'page': 5, 'key': BibleBook.james},
  {
    'name': '1 Peter',
    'abbreviation': '1 Pet',
    'page': 5,
    'key': BibleBook.firstPeter
  },
  {
    'name': '2 Peter',
    'abbreviation': '2 Pet',
    'page': 3,
    'key': BibleBook.secondPeter
  },
  {
    'name': '1 John',
    'abbreviation': '1 John',
    'page': 5,
    'key': BibleBook.firstJohn
  },
  {
    'name': '2 John',
    'abbreviation': '2 John',
    'page': 1,
    'key': BibleBook.secondJohn
  },
  {
    'name': '3 John',
    'abbreviation': '3 John',
    'page': 1,
    'key': BibleBook.thirdJohn
  },
  {'name': 'Jude', 'abbreviation': 'Jude', 'page': 1, 'key': BibleBook.jude},
  {
    'name': 'Revelation',
    'abbreviation': 'Rev',
    'page': 22,
    'key': BibleBook.revelation
  },
];

Map<BibleBook, String> bible_books_korean = {
  BibleBook.genesis: '창세기',
  BibleBook.exodus: '출애굽기',
  BibleBook.leviticus: '레위기',
  BibleBook.numbers: '민수기',
  BibleBook.deuteronomy: '신명기',
  BibleBook.joshua: '여호수아',
  BibleBook.judges: '사사기',
  BibleBook.ruth: '룻기',
  BibleBook.firstSamuel: '사무엘상',
  BibleBook.secondSamuel: '사무엘하',
  BibleBook.firstKings: '열왕기상',
  BibleBook.secondKings: '열왕기하',
  BibleBook.firstChronicles: '역대상',
  BibleBook.secondChronicles: '역대하',
  BibleBook.ezra: '에스라',
  BibleBook.nehemiah: '느헤미야',
  BibleBook.esther: '에스더',
  BibleBook.job: '욥기',
  BibleBook.psalms: '시편',
  BibleBook.proverbs: '잠언',
  BibleBook.ecclesiastes: '전도서',
  BibleBook.songOfSongs: '아가',
  BibleBook.isaiah: '이사야',
  BibleBook.jeremiah: '예레미야',
  BibleBook.lamentations: '예레미야애가',
  BibleBook.ezekiel: '에스겔',
  BibleBook.daniel: '다니엘',
  BibleBook.hosea: '호세아',
  BibleBook.joel: '요엘',
  BibleBook.amos: '아모스',
  BibleBook.obadiah: '오바댜',
  BibleBook.jonah: '요나',
  BibleBook.micah: '미가',
  BibleBook.nahum: '나훔',
  BibleBook.habakkuk: '하박국',
  BibleBook.zephaniah: '스바냐',
  BibleBook.haggai: '학개',
  BibleBook.zechariah: '스가랴',
  BibleBook.malachi: '말라기',
  BibleBook.matthew: '마태복음',
  BibleBook.mark: '마가복음',
  BibleBook.luke: '누가복음',
  BibleBook.john: '요한복음',
  BibleBook.acts: '사도행전',
  BibleBook.romans: '로마서',
  BibleBook.firstCorinthians: '고린도전서',
  BibleBook.secondCorinthians: '고린도후서',
  BibleBook.galatians: '갈라디아서',
  BibleBook.ephesians: '에베소서',
  BibleBook.philippians: '빌립보서',
  BibleBook.colossians: '골로새서',
  BibleBook.firstThessalonians: '데살로니가전서',
  BibleBook.secondThessalonians: '데살로니가후서',
  BibleBook.firstTimothy: '디모데전서',
  BibleBook.secondTimothy: '디모데후서',
  BibleBook.titus: '디도서',
  BibleBook.philemon: '빌레몬서',
  BibleBook.hebrews: '히브리서',
  BibleBook.james: '야고보서',
  BibleBook.firstPeter: '베드로전서',
  BibleBook.secondPeter: '베드로후서',
  BibleBook.firstJohn: '요한일서',
  BibleBook.secondJohn: '요한이서',
  BibleBook.thirdJohn: '요한삼서',
  BibleBook.jude: '유다서',
  BibleBook.revelation: '요한계시록',
};

String? toLocaleBibleBook(BuildContext context, BibleBook book) {
  final language = Localizations.localeOf(context).languageCode;
  if (language == 'ko') {
    return bible_books_korean[book];
  }
  return bible_books.firstWhere((element) => element['key'] == book)['name'];
}
