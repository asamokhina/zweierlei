// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TranslationsStruct extends BaseStruct {
  TranslationsStruct({
    String? detectedSourceLanguage,
    String? text,
  })  : _detectedSourceLanguage = detectedSourceLanguage,
        _text = text;

  // "detected_source_language" field.
  String? _detectedSourceLanguage;
  String get detectedSourceLanguage => _detectedSourceLanguage ?? 'default';
  set detectedSourceLanguage(String? val) => _detectedSourceLanguage = val;
  bool hasDetectedSourceLanguage() => _detectedSourceLanguage != null;

  // "text" field.
  String? _text;
  String get text => _text ?? 'default';
  set text(String? val) => _text = val;
  bool hasText() => _text != null;

  static TranslationsStruct fromMap(Map<String, dynamic> data) =>
      TranslationsStruct(
        detectedSourceLanguage: data['detected_source_language'] as String?,
        text: data['text'] as String?,
      );

  static TranslationsStruct? maybeFromMap(dynamic data) => data is Map
      ? TranslationsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'detected_source_language': _detectedSourceLanguage,
        'text': _text,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'detected_source_language': serializeParam(
          _detectedSourceLanguage,
          ParamType.String,
        ),
        'text': serializeParam(
          _text,
          ParamType.String,
        ),
      }.withoutNulls;

  static TranslationsStruct fromSerializableMap(Map<String, dynamic> data) =>
      TranslationsStruct(
        detectedSourceLanguage: deserializeParam(
          data['detected_source_language'],
          ParamType.String,
          false,
        ),
        text: deserializeParam(
          data['text'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TranslationsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TranslationsStruct &&
        detectedSourceLanguage == other.detectedSourceLanguage &&
        text == other.text;
  }

  @override
  int get hashCode => const ListEquality().hash([detectedSourceLanguage, text]);
}

TranslationsStruct createTranslationsStruct({
  String? detectedSourceLanguage,
  String? text,
}) =>
    TranslationsStruct(
      detectedSourceLanguage: detectedSourceLanguage,
      text: text,
    );
