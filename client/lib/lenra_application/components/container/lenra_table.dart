import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_component.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_row.dart';

// TODO : generate this from annotation on LenraTable
class LenraTableBuilder extends LenraComponentBuilder<LenraApplicationTable> {
  @override
  LenraApplicationTable map({children, centerChildren, border}) {
    return LenraApplicationTable(children: children, centerChildren: centerChildren, border: border);
  }

  Map<String, String> get propsTypes {
    return {
      "children": "List<Widget>",
      "centerChildren": "bool",
      "border": "bool",
    };
  }
}

class LenraApplicationTable extends StatelessLenraComponent {
  final List<LenraTableRow> children;
  final bool centerChildren;
  final bool border;

  LenraApplicationTable({
    this.children = const [],
    this.centerChildren,
    this.border,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return LenraTable(
      children: this.children,
      centerChildren: this.centerChildren,
      border: this.border,
    );
  }
}
