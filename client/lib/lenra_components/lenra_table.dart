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
  // final LenraTableHeadRow head;
  final List<LenraTableRow> children;
  final bool centerChildren;
  final bool border;
  final LenraComponentSize size;

  /// Creates a [LenraTable].
  LenraTable({
    // this.head,
    this.children,
    this.centerChildren = false,
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
              color: lenraTableThemeData.border.primaryBorder.color,
            )
          : null,
      children: buildChildren(
        // head: head,
        children: children,
        centerChildren: centerChildren ?? false,
        lenraTableThemeData: lenraTableThemeData,
        padding: lenraTableThemeData.padding.resolve(size),
      ),
    );
  }

  /// Returns a [List<TableRow>] of [TableRow] from a [List<LenraTableRow>] of [LenraTableRow].
  /// It is used to match the Flutter's [Table] children property.
  static List<TableRow> buildChildren({
    // LenraTableHeadRow head,
    List<LenraTableRow> children,
    bool centerChildren = false,
    LenraTableThemeData lenraTableThemeData,
    EdgeInsetsGeometry padding,
  }) {
    List<TableRow> tableChildren = [];
    // (head == null)
    //     ? []
    //     : [
    //         head.toTableHeadRow(
    //           lenraTableThemeData: lenraTableThemeData,
    //         ),
    //       ];
    tableChildren.addAll(children
        .map((lenraTableRow) => lenraTableRow.toTableRow(
              center: centerChildren,
              padding: padding,
            ))
        .toList());
    return tableChildren;
  }
}
