import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _GermanWordGlobal = ' ';
  String get GermanWordGlobal => _GermanWordGlobal;
  set GermanWordGlobal(String value) {
    _GermanWordGlobal = value;
  }

  // String _ToTranslateGlobal = ' ';
  // String get ToTranslateGlobal => _ToTranslateGlobal;
  // set ToTranslateGlobal(String value) {
  //   _ToTranslateGlobal = value;
  // }

//   String _ToGrammar = ' ';
//   String get ToGrammar => _ToGrammar;
//   set ToGrammar(String value) {
//     _ToGrammar = value;
//   }
}
