import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/lenra_button.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/lenra_checkbox.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/lenra_radio.dart';
import 'package:fr_lenra_client/lenra_application/components/actionable/lenra_textfield.dart';
import 'package:fr_lenra_client/lenra_application/components/container/lenra_container.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_image.dart';
import 'package:fr_lenra_client/lenra_application/components/lenra_text.dart';
import 'package:fr_lenra_client/lenra_application/lenra_component_builder.dart';
import 'package:fr_lenra_client/lenra_application/lenra_ui_builder.dart';
import 'package:fr_lenra_client/lenra_application/props_parser.dart';
import 'package:fr_lenra_client/lenra_application/update_props_event.dart';

extension LenraComponentWrapperExt on LenraWrapper {
  static final Map<String, LenraComponentBuilder> componentsMapping = {
    'container': LenraContainerBuilder(),
    'text': LenraTextBuilder(),
    'textfield': LenraTextfieldBuilder(),
    'button': LenraButtonBuilder(),
    'checkbox': LenraCheckboxBuilder(),
    'image': LenraImageBuilder(),
    'radio': LenraRadioBuilder(),
    // 'table': LenraTableBuilder(),
  };
}

class LenraWrapper extends StatefulWidget {
  final LenraUiBuilderState lenraUiBuilderState;
  final Map<String, dynamic> initialProperties;
  final String id;

  LenraWrapper(this.id, this.lenraUiBuilderState, this.initialProperties, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LenraWrapperState();
  }
}

class LenraWrapperState extends State<LenraWrapper> {
  //? This is the Json representation of the Lenra UIComponent
  late Map<Symbol, dynamic> parsedProps;
  late LenraComponentBuilder componentBuilder;

  @override
  void initState() {
    super.initState();
    this.parseProps(widget.initialProperties);
    this.widget.lenraUiBuilderState.updateWidgetStream.stream.listen((UpdatePropsEvent event) {
      if (event.id == widget.id) {
        this.updateProperties(event.properties);
      }
    });
  }

  void parseProps(Map<String, dynamic> properties) {
    String? type = properties['type'] as String?;
    if (type == null) throw "No type in component. It should never happen";
    if (!LenraComponentWrapperExt.componentsMapping.containsKey(type))
      throw "Componnent mapping does not handle type $type";
    this.componentBuilder = LenraComponentWrapperExt.componentsMapping[type]!;
    this.parsedProps = Parser.parseProps(properties, this.componentBuilder.propsTypes);

    if (properties["children"] != null) {
      this.parsedProps[Symbol("children")] = widget.lenraUiBuilderState.getChildrenWidgets(properties["children"]);
    }
  }

  void updateProperties(Map<String, dynamic> properties) {
    setState(() {
      this.parseProps(properties);
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.componentBuilder.build(parsedProps);
  }
}
