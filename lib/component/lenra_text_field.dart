import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenra_components/theme/text_field_style.dart';

class LenraTextField extends StatelessWidget {
  final bool autocorrect;
  final List<String>? autofillHints;
  final bool autofocus;
  final InputCounterWidgetBuilder? buildCounter;
  final TextEditingController? controller;
  final TextFieldStyle? style;
  final DragStartBehavior dragStartBehavior;
  final bool? enabled;
  final bool enableIMEPersonalizedLearning;
  final bool enableInteractiveSelection;
  final bool enableSuggestions;
  final bool expands;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? formatters;
  final TextInputType keyboardType;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final MouseCursor? mouseCursor;
  final bool obscureText;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final GestureTapCallback? onTap;
  final bool readOnly;
  // final String? restorationId; Needs more work to be implemented, see https://medium.com/flutter-community/flutter-state-restoration-restore-scrollviews-and-textfields-d1d35cbd878c
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final TextSelectionControls? selectionControls;
  final bool? showCursor;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final TextCapitalization textCapitalization;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final ToolbarOptions? toolbarOptions;

  const LenraTextField({
    Key? key,
    this.autocorrect = true,
    this.autofillHints,
    this.autofocus = false,
    this.buildCounter,
    this.controller,
    this.style,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enabled,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection = true,
    this.enableSuggestions = true,
    this.expands = false,
    this.focusNode,
    this.formatters,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines = 1,
    this.mouseCursor,
    this.obscureText = false,
    this.onAppPrivateCommand,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.scrollController,
    this.scrollPhysics,
    this.selectionControls,
    this.showCursor = false,
    this.smartDashesType,
    this.smartQuotesType,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.textInputAction,
    this.toolbarOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: autocorrect,
      autofillHints: autofillHints,
      autofocus: autofocus,
      buildCounter: buildCounter,
      controller: controller,
      style: style?.textStyle,
      cursorColor: style?.cursorColor,
      cursorHeight: style?.cursorHeight,
      cursorRadius: style?.cursorRadius,
      cursorWidth: style?.cursorWidth ?? 2.0,
      decoration: style?.decoration,
      keyboardAppearance: style?.keyboardAppearance,
      obscuringCharacter: style?.obscuringCharacter ?? '•',
      scrollPadding: style?.scrollPadding ?? const EdgeInsets.all(20.0),
      selectionHeightStyle: style?.selectionHeightStyle ?? BoxHeightStyle.tight,
      selectionWidthStyle: style?.selectionWidthStyle ?? BoxWidthStyle.tight,
      strutStyle: style?.strutStyle,
      textAlign: style?.textAlign ?? TextAlign.start,
      textAlignVertical: style?.textAlignVertical,
      dragStartBehavior: dragStartBehavior,
      enabled: enabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      enableInteractiveSelection: enableInteractiveSelection,
      enableSuggestions: enableSuggestions,
      expands: expands,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: maxLines,
      minLines: minLines,
      mouseCursor: mouseCursor,
      obscureText: obscureText,
      onAppPrivateCommand: onAppPrivateCommand,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onTap: onTap,
      readOnly: readOnly,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      selectionControls: selectionControls,
      showCursor: showCursor,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      textCapitalization: textCapitalization,
      textDirection: textDirection,
      textInputAction: textInputAction,
      toolbarOptions: toolbarOptions,
    );
  }
}
