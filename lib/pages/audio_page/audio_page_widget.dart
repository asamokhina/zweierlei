import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:provider/provider.dart';
import 'audio_page_model.dart';
export 'audio_page_model.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'dart:developer' as developer;

class AudioPageWidget extends StatefulWidget {
  const AudioPageWidget({
    super.key,
    String? wordInput,
  }) : wordInput = wordInput ?? 'error';

  final String wordInput;

  @override
  State<AudioPageWidget> createState() => _AudioPageWidgetState();
}

class _AudioPageWidgetState extends State<AudioPageWidget> {
  late AudioPageModel _model;

  final SpeechToText _speechToText = SpeechToText();
  String _currentLocaleId = 'de_DE';

  bool _speechEnabled = false;
  String lastWord = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AudioPageModel());

    _model.inputFieldTextController ??= TextEditingController();
    _model.inputFieldFocusNode ??= FocusNode();
    _initSpeech();

    initAsyncState();
  }

  void initAsyncState() async {
    await Permission.microphone.request();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening(String mode) async {
    // store callback function in variable
    void Function(SpeechRecognitionResult result) onRes;
    developer.log("_startListening", name: '_startListening');
    if (mode == 'translate') {
      _currentLocaleId = 'en_EN';
      onRes = _onSpeechResultTranslate;
    } else {
      _currentLocaleId = 'de_DE';
      onRes = _onSpeechResultGrammar;
    }
    await _speechToText.listen(
      onResult: onRes,
      // listenFor: Duration(seconds: 30),
      localeId: _currentLocaleId,
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResultTranslate(SpeechRecognitionResult result) async {
    var _lastWords = result.recognizedWords;
    if (_lastWords.isEmpty) {
      return;
    }
    setState(() {
      lastWord = _lastWords.split(' ').last;
    });

    await translateWord(lastWord);
  }

  void _onSpeechResultGrammar(SpeechRecognitionResult result) async {
    var _lastWords = result.recognizedWords;
    if (_lastWords.isEmpty) {
      return;
    }
    setState(() {
      lastWord = _lastWords.split(' ').last;
      FFAppState().GermanWordGlobal = lastWord;
      developer.log(lastWord, name: '_onSpeechResultGrammar');
    });
    developer.log(lastWord, name: '_onSpeechResultGrammar');
    developer.log(FFAppState().GermanWordGlobal,
        name: '_onSpeechResultGrammar');
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    var appBarTitle = Text(
      ' ',
      style: FlutterFlowTheme.of(context).headlineMedium.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22.0,
            letterSpacing: 0.0,
          ),
    );
    return GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
            : FocusScope.of(context).unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              title: appBarTitle,
              actions: const [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: safeAreaWidget(context)));
  }

  SafeArea safeAreaWidget(BuildContext context) {
    return SafeArea(
        top: true,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  translateButtonExpansion(context),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  grammarButtonExpansion(context),
                ],
              ),
              Row(
                children: <Widget>[
                  recognizedWordsContainer(),
                  lastWordsExpansion(),
                ],
              ),
              Expanded(
                child: translationOutputContainer(context),
              ),
            ]));
  }

  Container translationOutputContainer(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Column(
          children: [
            germanWordAlignment(context),
            grammarListExpansion(),
          ],
        ));
  }

  Container recognizedWordsContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Text(
        'Recognized words:',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Expanded grammarListExpansion() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
        child: grammarListFutureBuilder(),
      ),
    );
  }

  FutureBuilder<List<GetWordRow>> grammarListFutureBuilder() {
    return FutureBuilder<List<GetWordRow>>(
      key: ValueKey(FFAppState().GermanWordGlobal),
      future: SQLiteManager.instance.getWord(
        inputWord: FFAppState().GermanWordGlobal.isNotEmpty
            ? FFAppState().GermanWordGlobal
            : 'error',
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return progressCircle(context);
        }
        final listViewGetWordRowList = snapshot.data!;
        return ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: listViewGetWordRowList.length,
          itemBuilder: (context, listViewIndex) {
            final listViewGetWordRow = listViewGetWordRowList[listViewIndex];
            return ListTile(
              title: grammarText(listViewGetWordRow, context),
              subtitle: grundformText(listViewGetWordRow, context),
              tileColor: FlutterFlowTheme.of(context).secondaryBackground,
              dense: false,
            );
          },
        );
      },
    );
  }

  Text grundformText(GetWordRow listViewGetWordRow, BuildContext context) {
    return Text(
      'Grundform: ${listViewGetWordRow.grundform}',
      style: FlutterFlowTheme.of(context).labelMedium.override(
            fontFamily: 'Roboto',
            letterSpacing: 0.0,
          ),
    );
  }

  Text grammarText(GetWordRow listViewGetWordRow, BuildContext context) {
    return Text(
      listViewGetWordRow.grammar!,
      style: FlutterFlowTheme.of(context).titleSmall.override(
            fontFamily: 'Poppins',
            letterSpacing: 0.0,
          ),
    );
  }

  Center progressCircle(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            FlutterFlowTheme.of(context).primary,
          ),
        ),
      ),
    );
  }

  Align germanWordAlignment(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, -0.83),
      child: Text(
        FFAppState().GermanWordGlobal,
        textAlign: TextAlign.start,
        style: FlutterFlowTheme.of(context).displaySmall.override(
              fontFamily: 'Poppins',
              letterSpacing: 0.0,
            ),
      ),
    );
  }

  Expanded lastWordsExpansion() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          // If listening is active show the recognized words
          lastWord.isNotEmpty
              ? lastWord
              : _speechEnabled
                  ? 'Tap the microphone to start listening...'
                  : 'Speech not available',
        ),
      ),
    );
  }

  Expanded grammarButtonExpansion(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
      // Grammar button
      child: ElevatedButton.icon(
          onPressed: () {
            setState(() {});
            if (_speechToText.isNotListening) {
              _startListening('grammar');
            } else {
              _stopListening();
            }
          },
          icon: Icon(
            _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
            color: Colors.white,
          ),
          label: audioIconText('GRAMMAR'),
          style: audioButtonStyle(context)),
    ));
  }

  Expanded translateButtonExpansion(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),

        // Translate button
        child: ElevatedButton.icon(
          onPressed: () async {
            setState(() {});
            if (_speechToText.isNotListening) {
              _startListening('translate');
            } else {
              _stopListening();
            }
          },
          icon: Icon(
            _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
            color: Colors.white,
          ),
          label: audioIconText('TRANSLATE'),
          style: audioButtonStyle(context),
        ),
      ),
    );
  }

  Text audioIconText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: Colors.white,
        letterSpacing: 0.0,
      ),
    );
  }

  ButtonStyle audioButtonStyle(BuildContext context) {
    return ButtonStyle(
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24.0)),
      backgroundColor:
          MaterialStateProperty.all(FlutterFlowTheme.of(context).primary),
      elevation: MaterialStateProperty.all(3.0),
      side: MaterialStateProperty.all(const BorderSide(
        color: Colors.transparent,
        width: 1.0,
      )),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      )),
    );
  }

  Future<void> translateWord(String word) async {
    var translation = await performGetTranslation(
      SQLiteManager.instance.database,
      inputWord: word,
    );
    setTranslationVar(translation);

    debugPrint(FFAppState().GermanWordGlobal);
  }

  void setTranslationVar(String? translation) {
    setState(() {
      FFAppState().GermanWordGlobal = valueOrDefault<String>(
        translation,
        'Error: No translation found.',
      );
    });
  }
}
