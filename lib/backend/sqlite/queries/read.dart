import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN GETWORD
Future<List<GetWordRow>> performGetWord(
  Database database, {
  String? inputWord,
}) {
final query = '''
SELECT 
    form,
    grundform,
    "0",
    "1",
    "2"
    "3",
    "4",
    "5",
    GROUP_CONCAT("6", " | ") as output
FROM 
    tags_data_mapped
WHERE 
    LOWER(form) = LOWER('$inputWord')
GROUP BY 
    grundform, "0", "1", "2", "3", "4", "5";
''';
  return _readQuery(database, query, (d) => GetWordRow(d));
}

class GetWordRow extends SqliteRow {
  GetWordRow(super.data);

  // String? get mappedTags => data['mapped_tags'] as String?;
  String? get form => data['form'] as String?;
  String? get grundform => data['grundform'] as String?;
  //String? get tags => data['tags'] as String?;
  // concat columns "0", "1", "2", "3", "4", "5" as a single string
  String? get grammar {
    final values = [
      data['0'],
      data['1'],
      data['2'],
      data['3'],
      data['4'],
      data['5'],
      data['output'],
    ];
    final filteredValues = values.where((value) => value != null).toList();
    return filteredValues.join(', ');
  }
}

/// END GETWORD
Future<String?> performGetTranslation(Database database, {String? inputWord}) async {
  final query = '''
  SELECT 
    form
  FROM 
    tags_data_mapped
  WHERE 
    LOWER(english) = LOWER('$inputWord')
  LIMIT 1;
  ''';
  final List<Map<String, dynamic>> results = await database.rawQuery(query);
  if (results.isNotEmpty && results.first['form'] != null) {
    return results.first['form'] as String;
  }
  return null;
}