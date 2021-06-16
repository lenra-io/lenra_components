import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_table_theme_data.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

/// Lenra implementation of Flutter's [Table] widget.
///
/// The children of this widget should be of type [LenraTableRow].
/// The [centerChildren] property is used to vertically and horizontally center each child of the table.
/// The [border] property is used to show a thin black border around each cell of the table.
///
/// In case it is needed to put an empty [LenraTableCell] in the [Table], just set a `null` child in the [LenraTableRow].
/// Example :
/// ```dart
/// LenraTable(
///   children: [
///     LenraTableRow(
///       children: [
///         Text("example"),
///         null, // This will show an empty cell
///       ],
///     ),
///   ],
/// ),
/// ```
class LenraTable extends StatelessWidget {
  final List<LenraTableRow> children;
  final bool border;
  final LenraComponentSize size;

  /// Creates a [LenraTable].
  LenraTable({
    required this.children,
    this.border = false,
    this.size = LenraComponentSize.Medium,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LenraTheme.of(context);
    final LenraTableThemeData lenraTableThemeData = theme.lenraTableThemeData;

    return Table(
      border: border
          ? TableBorder.all(
              color: lenraTableThemeData.getBorderColor(),
            )
          : null,
      children: buildChildren(
        children: children,
        lenraTableThemeData: lenraTableThemeData,
        padding: lenraTableThemeData.getPadding(size),
      ),
    );
  }

  /// Returns a [List<TableRow>] of [TableRow] from a [List<LenraTableRow>] of [LenraTableRow].
  /// It is used to match the Flutter's [Table] children property.
  static List<TableRow> buildChildren({
    required List<LenraTableRow> children,
    required LenraTableThemeData lenraTableThemeData,
    required EdgeInsetsGeometry padding,
  }) {
    return children
        .map((lenraTableRow) => lenraTableRow.toTableRow(
              padding: padding,
              theme: lenraTableThemeData,
            ))
        .toList();
  }
}
