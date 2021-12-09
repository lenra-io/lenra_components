import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenra_components/component/lenra_text_field.dart';
import 'package:lenra_components/theme/lenra_text_field_style.dart';
import 'package:lenra_components/utils/form_validators.dart';

enum LenraTextFormFieldType {
  password,
  email,
  normal,
}

Function emailValidator(Function? aditionalValidator) {
  return validator(
    [
      checkNotEmpty(),
      checkLength(min: 2, max: 64),
      checkEmailFormat(),
      (aditionalValidator != null) ? aditionalValidator() : (String? value) {},
    ],
  );
}

Function passwordValidator(Function? aditionalValidator) {
  return validator(
    [
      checkNotEmpty(),
      checkLength(min: 8, max: 64),
      checkPassword(),
      (aditionalValidator != null) ? aditionalValidator() : (String? value) {},
    ],
  );
}

class LenraTextFormField extends FormField<String> {
  final LenraTextFormFieldType type;
  final bool autocorrect;
  final List<String>? autofillHints;
  final bool autofocus;
  final InputCounterWidgetBuilder? buildCounter;
  final TextEditingController? controller;
  final LenraTextFieldStyle? style;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final bool enableSuggestions = true;
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
  final TextCapitalization textCapitalization;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final ToolbarOptions? toolbarOptions;

  LenraTextFormField({
    Key? key,
    String initialValue = "",
    FormFieldValidator<String>? validator,
    this.type = LenraTextFormFieldType.normal,
    this.autocorrect = true,
    this.autofillHints,
    this.autofocus = false,
    this.buildCounter,
    this.controller,
    this.style,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
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
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.textInputAction,
    this.toolbarOptions,
    AutovalidateMode? autovalidateMode = AutovalidateMode.always,
    bool? enabled,
  })  : assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        super(
          key: key,
          initialValue: initialValue,
          validator: validator,
          enabled: enabled ?? true,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState field) {
            final _LenraTextFormField state = field as _LenraTextFormField;
            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            return LenraTextField(
              autocorrect: autocorrect,
              autofillHints: autofillHints,
              autofocus: autofocus,
              buildCounter: buildCounter,
              controller: state._effectiveController,
              style: LenraTextFieldStyle(
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
              ),
              dragStartBehavior: dragStartBehavior,
              enableInteractiveSelection: enableInteractiveSelection,
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
              onChanged: onChangedHandler,
              onEditingComplete: onEditingComplete,
              enabled: enabled ?? true,
              onSubmitted: onSubmitted,
              onTap: onTap,
              readOnly: readOnly,
              scrollController: scrollController,
              scrollPhysics: scrollPhysics,
              selectionControls: selectionControls,
              showCursor: showCursor,
              textCapitalization: textCapitalization,
              textDirection: textDirection,
              textInputAction: textInputAction,
              toolbarOptions: toolbarOptions,
            );
          },
        );

  @override
  FormFieldState<String> createState() => _LenraTextFormField();
}

class _LenraTextFormField extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController => widget.controller ?? _controller!.value;

  @override
  LenraTextFormField get widget => super.widget as LenraTextFormField;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    // Make sure to update the internal [FormFieldState] value to sync up with
    // text editing controller value.
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _createLocalController(widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(TextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) _effectiveController.text = value ?? '';
  }

  @override
  void reset() {
    // setState will be called in the superclass, so even though state is being
    // manipulated, no setState call is needed here.
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) didChange(_effectiveController.text);
  }
}
