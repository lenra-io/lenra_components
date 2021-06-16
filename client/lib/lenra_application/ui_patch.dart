enum UIPatchOperation {
  add,
  addChild,
  remove,
  removeChild,
  replace,
  replaceChild,
}

extension UILenraOperationExtension on UIPatchOperation {
  UIPatchOperation toChildOperation() {
    switch (this) {
      case UIPatchOperation.add:
        return UIPatchOperation.addChild;
      case UIPatchOperation.remove:
        return UIPatchOperation.removeChild;
      case UIPatchOperation.replace:
        return UIPatchOperation.replaceChild;
      default:
        throw "Unhandled UI Patch Operation";
    }
  }
}

// Extends the String object to be able to transform it to UiPatchOperation
extension UILenraOperationStringExtension on String {
  UIPatchOperation toLenraUiPatchOperation() {
    switch (this) {
      case "add":
        return UIPatchOperation.add;
      case "remove":
        return UIPatchOperation.remove;
      case "replace":
        return UIPatchOperation.replace;
      default:
        throw "Unhandled UI Patch Operation";
    }
  }

  bool isInteger() {
    return int.tryParse(this) != null;
  }
}

class UiPatchEvent {
  String id;
  UIPatchOperation operation;
  List<String> propertyPathList;
  dynamic value;
  int childIndex;
  String? childId;

  static RegExp regex = RegExp(
      r"^(?<target>\/root(?:\/children\/\d+)*)(?<property>(?:\/children)?(?:\/(?!children)(?:[\da-zA-Z_-])+)*)$");

  UiPatchEvent(
    this.id,
    this.operation,
    this.propertyPathList,
    this.value,
    this.childIndex,
    this.childId,
  );

/*

^(\/root(?:\/children\/\d+)*(?:\/children)?)((?:\/(?!children)(?:[\da-zA-Z_-])+)*)$

Breaks apart : 
^(\/root(?:\/children\/\d+)*(?:\/children)?)
  => Start with /root (mandatory)
  => can have 0 to N of :
    => /children/xx

((?:\/(?!children)(?:[\da-zA-Z_-])+)*)$
  => 0 to N of : 
   /<json_key>
   Excepting /children

 /root/children/0/children/1 /value
 /root/children/0/children/1 /listeners/onClick/code

^\/root(\/children\/\d+)+$ => /root/children/0/children/0
^\/root(\/children\/\d+)*\/children$ => 
/root/children/0/children
/root/children

*/

  factory UiPatchEvent.fromPatch(Map<String, dynamic> patch) {
    UIPatchOperation operation = (patch['op'] as String).toLenraUiPatchOperation();
    dynamic value = patch['value'];

    RegExpMatch? match = regex.firstMatch(patch["path"]);
    if (match == null) {
      throw "Could not match path regex";
    }

    String? target = match.namedGroup("target");
    String? property = match.namedGroup("property");
    if (target == null) throw "Could not match target group in regex";
    if (property == null) throw "Could not match property group in regex";

    List<String> propertyPathList = property.split("/");
    propertyPathList.removeAt(0);
    List<String> targetPathList = target.split('/');

    // 2 possibilities here :
    // 1 - property list is empty => We have to send the event to the parent to add/replace/remove the child
    // 2 - End with any component property => Send the event to the component.
    bool changeOneChild = propertyPathList.isEmpty;

    if (changeOneChild) {
      int childIndex = int.parse(targetPathList.last);
      String id = targetPathList.sublist(0, targetPathList.length - 2).join('/');

      return UiPatchEvent(id, operation.toChildOperation(), propertyPathList, value, childIndex, target);
    }

    return UiPatchEvent(target, operation, propertyPathList, value, -1, null);
  }
}
