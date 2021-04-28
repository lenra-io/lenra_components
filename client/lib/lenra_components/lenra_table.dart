import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_row.dart';

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
  final bool centerChildren;
  final bool border;

  /// Creates a [LenraTable].
  LenraTable({this.children, this.centerChildren = false, this.border = false});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: border ? TableBorder.all() : null,
      children: buildChildren(
        children: children,
        centerChildren: centerChildren ?? false,
      ),
    );
  }

  /// Returns a [List<TableRow>] of [TableRow] from a [List<LenraTableRow>] of [LenraTableRow].
  /// It is used to match the Flutter's [Table] children property.
  static List<TableRow> buildChildren({List<LenraTableRow> children, bool centerChildren = false}) {
    return children.map((lenraTableRow) => lenraTableRow.toTableRow(center: centerChildren)).toList();
  }
}
