
// import '/backend/api_requests/api_calls.dart';
// import '/backend/sqlite/sqlite_manager.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'home_page_model.dart';
// export 'home_page_model.dart';

// class HomePageWidget extends StatefulWidget {
//   const HomePageWidget({
//     super.key,
//     String? wordInput,
//   }) : wordInput = wordInput ?? 'error';

//   final String wordInput;

//   @override
//   State<HomePageWidget> createState() => _HomePageWidgetState();
// }

// class _HomePageWidgetState extends State<HomePageWidget> {
//   late HomePageModel _model;
//   bool _showGrammar = false;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => HomePageModel());

//     _model.inputFieldTextController ??= TextEditingController();
//     _model.inputFieldFocusNode ??= FocusNode();
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     context.watch<FFAppState>();

//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         appBar: AppBar(
//           backgroundColor: FlutterFlowTheme.of(context).primary,
//           automaticallyImplyLeading: false,
//           title: Text(
//             ' ',
//             style: FlutterFlowTheme.of(context).headlineMedium.override(
//                   fontFamily: 'Poppins',
//                   color: Colors.white,
//                   fontSize: 22.0,
//                   letterSpacing: 0.0,
//                 ),
//           ),
//           actions: const [],
//           centerTitle: false,
//           elevation: 2.0,
//         ),
//         body: SafeArea(
//           top: true,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
//                 child: TextFormField(
//                   controller: _model.inputFieldTextController,
//                   focusNode: _model.inputFieldFocusNode,
//                   autofocus: true,
//                   obscureText: false,
//                   decoration: InputDecoration(
//                     labelText: 'z.B....',
//                     labelStyle:
//                         FlutterFlowTheme.of(context).labelMedium.override(
//                               fontFamily: 'Roboto',
//                               letterSpacing: 0.0,
//                             ),
//                     hintStyle:
//                         FlutterFlowTheme.of(context).labelMedium.override(
//                               fontFamily: 'Roboto',
//                               letterSpacing: 0.0,
//                             ),
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: FlutterFlowTheme.of(context).alternate,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: FlutterFlowTheme.of(context).primary,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     errorBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: FlutterFlowTheme.of(context).error,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     focusedErrorBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: FlutterFlowTheme.of(context).error,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     suffixIcon: IconButton(
//                         onPressed: _model.inputFieldTextController?.clear,
//                       icon: const Icon(Icons.clear),
//                     ),
//                   ),
//                   style: FlutterFlowTheme.of(context).bodyLarge.override(
//                         fontFamily: 'Roboto',
//                         letterSpacing: 0.0,
//                       ),
//                   validator: _model.inputFieldTextControllerValidator
//                       .asValidator(context),
//                 ),
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                       child: FFButtonWidget(
//                         onPressed: () async {
//                           setState(() {
//                             _showGrammar = false;
//                           });
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           await setTranslateStates(context);
//                         },
//                         text: 'TRANSLATE',
//                         options: FFButtonOptions(
//                           height: 100.0,
//                           padding: const EdgeInsetsDirectional.fromSTEB(
//                               24.0, 0.0, 24.0, 0.0),
//                           iconPadding: const EdgeInsetsDirectional.fromSTEB(
//                               0.0, 0.0, 0.0, 0.0),
//                           color: FlutterFlowTheme.of(context).primary,
//                           textStyle:
//                               FlutterFlowTheme.of(context).titleSmall.override(
//                                     fontFamily: 'Roboto',
//                                     color: Colors.white,
//                                     letterSpacing: 0.0,
//                                   ),
//                           elevation: 3.0,
//                           borderSide: const BorderSide(
//                             color: Colors.transparent,
//                             width: 1.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                       child: FFButtonWidget(
//                         onPressed: () {
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           setState(() {
//                             _showGrammar = true;
//                           });
//                           setState(() {
//                             FFAppState().ToTranslateGlobal = _model.inputFieldTextController.text;
//                           });
//                         },
//                         text: 'GRAMMAR',
//                         options: FFButtonOptions(
//                           height: 100.0,
//                           padding: const EdgeInsetsDirectional.fromSTEB(
//                               24.0, 0.0, 24.0, 0.0),
//                           iconPadding: const EdgeInsetsDirectional.fromSTEB(
//                               0.0, 0.0, 0.0, 0.0),
//                           color: FlutterFlowTheme.of(context).primary,
//                           textStyle:
//                               FlutterFlowTheme.of(context).titleSmall.override(
//                                     fontFamily: 'Roboto',
//                                     color: Colors.white,
//                                     letterSpacing: 0.0,
//                                   ),
//                           elevation: 3.0,
//                           borderSide: const BorderSide(
//                             color: Colors.transparent,
//                             width: 1.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   height: 100.0,
//                   decoration: BoxDecoration(
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                   ),
//                   child: Stack(
//                     children: [
//                       if (!_showGrammar)
//                         // Align(
//                         //   alignment: AlignmentDirectional(0.0, -0.83),
//                         //   child: Text(
//                         //     FFAppState().ToGrammar,
//                         //     textAlign: TextAlign.start,
//                         //     style: FlutterFlowTheme.of(context)
//                         //         .displaySmall
//                         //         .override(
//                         //           fontFamily: 'Poppins',
//                         //           letterSpacing: 0.0,
//                         //         ),
//                         //   ),
//                         // ),
//                       Align(
//                         alignment: const AlignmentDirectional(0.0, -0.83),
//                         child: Text(
//                           FFAppState().GermanWordGlobal,
//                           textAlign: TextAlign.start,
//                           style: FlutterFlowTheme.of(context)
//                               .displaySmall
//                               .override(
//                                 fontFamily: 'Poppins',
//                                 letterSpacing: 0.0,
//                               ),
//                         ),
//                       ),
//                       if (_showGrammar)
//                       Align(
//                         alignment: const AlignmentDirectional(0.0, 0.0),
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(
//                               0.0, 0.0, 0.0, 50.0),
//                           child: FutureBuilder<List<GetWordRow>>(
//                             future: SQLiteManager.instance.getWord(
//                               inputWord: FFAppState().ToTranslateGlobal,
//                             ),
//                             builder: (context, snapshot) {
//                               // Customize what your widget looks like when it's loading.
//                               if (!snapshot.hasData) {
//                                 return Center(
//                                   child: SizedBox(
//                                     width: 50.0,
//                                     height: 50.0,
//                                     child: CircularProgressIndicator(
//                                       valueColor: AlwaysStoppedAnimation<Color>(
//                                         FlutterFlowTheme.of(context).primary,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                               final listViewGetWordRowList = snapshot.data!;
//                               return ListView.builder(
//                                 padding: EdgeInsets.zero,
//                                 scrollDirection: Axis.vertical,
//                                 itemCount: listViewGetWordRowList.length,
//                                 itemBuilder: (context, listViewIndex) {
//                                   final listViewGetWordRow =
//                                       listViewGetWordRowList[listViewIndex];
//                                   return ListTile(
//                                     title: Text(
//                                       'Grundform: ${listViewGetWordRow.grundform}',
//                                       style: FlutterFlowTheme.of(context)
//                                           .titleLarge
//                                           .override(
//                                             fontFamily: 'Poppins',
//                                             letterSpacing: 0.0,
//                                           ),
//                                     ),
//                                     subtitle: Text(
//                                       listViewGetWordRow.grammar!,
//                                       style: FlutterFlowTheme.of(context)
//                                           .labelMedium
//                                           .override(
//                                             fontFamily: 'Roboto',
//                                             letterSpacing: 0.0,
//                                           ),
//                                     ),
//                                     trailing: Icon(
//                                       Icons.arrow_forward_ios,
//                                       color: FlutterFlowTheme.of(context)
//                                           .secondaryText,
//                                       size: 20.0,
//                                     ),
//                                     tileColor: FlutterFlowTheme.of(context)
//                                         .secondaryBackground,
//                                     dense: false,
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> setTranslateStates(BuildContext context) async {
//     setState(() {
//         FFAppState().GermanWordGlobal = '';
//       });
//     setState(() {
//       FFAppState().ToTranslateGlobal =
//           _model.inputFieldTextController.text;
//     });
//     // setState(() {
//     //   FFAppState().ToGrammar = ' ';
//     // });
//     _model.response = await EnToDeAPICallCall.call(
//       toTranslate: FFAppState().ToTranslateGlobal,
//     );
//     if ((_model.response?.succeeded ?? true)) {
//       setState(() {
//         FFAppState().GermanWordGlobal =
//             valueOrDefault<String>(
//           EnToDeAPICallCall.translationResponse(
//             (_model.response?.jsonBody ?? ''),
//           ),
//           'errorInSetVar',
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'API call failed',
//             style: TextStyle(
//               color: FlutterFlowTheme.of(context)
//                   .primaryText,
//             ),
//           ),
//           duration: const Duration(milliseconds: 4000),
//           backgroundColor:
//               FlutterFlowTheme.of(context).secondary,
//         ),
//       );
//     }
    
//     setState(() {});
//   }
// }
