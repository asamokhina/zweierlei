
import '/flutter_flow/flutter_flow_util.dart';
import 'audio_page_widget.dart' show AudioPageWidget;
import 'package:flutter/material.dart';

class AudioPageModel extends FlutterFlowModel<AudioPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for InputField widget.
  FocusNode? inputFieldFocusNode;
  TextEditingController? inputFieldTextController;
  String? Function(BuildContext, String?)? inputFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (EnToDeAPICall)] action in TranslateButton widget.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    inputFieldFocusNode?.dispose();
    inputFieldTextController?.dispose();
  }
}
