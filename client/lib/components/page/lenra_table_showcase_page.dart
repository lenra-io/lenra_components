import 'package:flutter/material.dart';
import 'package:fr_lenra_client/components/page/simple_page.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_text.dart';
import 'package:fr_lenra_client/lenra_components/layout/lenra_column.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table.dart';
import 'package:fr_lenra_client/lenra_components/lenra_table_row.dart';
import 'package:fr_lenra_client/lenra_components/theme/lenra_theme_data.dart';

/*
//This page its just for leanraTable developpment, remove before merge
*/
class LenraTableShowcasePage extends StatelessWidget {
  static const routeName = "/showcase";

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      child: LenraColumn(
        children: [
          LenraTable(
            border: true,
            size: LenraComponentSize.Small,
            // head: LenraTableHeadRow(children: [
            //   LenraText(value: "Row1Cell1"),
            //   LenraText(value: "Row1Cell2"),
            // ]),
            children: [
              LenraTableRow(children: [
                LenraText(value: "Row1Cell1"),
                LenraText(value: "Row1Cell2"),
              ]),
              LenraTableRow(children: [
                LenraText(value: "Row2Cell1"),
                LenraText(value: "Row2Cell2"),
              ])
            ],
          ),
          LenraTable(
            border: true,
            // head: LenraTableHeadRow(children: [
            //   LenraText(value: "Row1Cell1"),
            //   LenraText(value: "Row1Cell2"),
            // ]),
            children: [
              LenraTableRow(children: [
                LenraText(value: "Row1Cell1"),
                LenraText(value: "Row1Cell2"),
              ]),
              LenraTableRow(children: [
                LenraText(value: "Row2Cell1"),
                LenraText(value: "Row2Cell2"),
              ])
            ],
          ),
          LenraTable(
            border: true,
            centerChildren: true,
            size: LenraComponentSize.Large,
            // head: LenraTableHeadRow(children: [
            //   LenraText(value: "Row1Cell1"),
            //   LenraText(value: "Row1Cell2"),
            // ]),
            children: [
              LenraTableRow(children: [
                LenraText(value: "Row1Cell1"),
                LenraText(value: "Row1Cell2"),
              ]),
              LenraTableRow(children: [
                LenraText(value: "Row2Cell1"),
                LenraText(value: "Row2Cell2"),
              ])
            ],
          ),
        ],
      ),
    );
  }
}
