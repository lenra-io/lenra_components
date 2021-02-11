enum UILenraOperation {
  add,
  addChild,
  remove,
  removeChild,
  replace,
  replaceChild,
  replaceChildType,
}

extension UILenraOperationExtension on UILenraOperation {
  UILenraOperation toChildOperation() {
    switch (this) {
      case UILenraOperation.add:
        return UILenraOperation.addChild;
      case UILenraOperation.remove:
        return UILenraOperation.removeChild;
      case UILenraOperation.replace:
        return UILenraOperation.replaceChild;
      default:
        return null;
    }
  }
}

// Extends the String object to be able to transform it to UiPatchOperation
extension UILenraOperationStringExtension on String {
  UILenraOperation toLenraUiPatchOperation() {
    switch (this) {
      case "add":
        return UILenraOperation.add;
      case "remove":
        return UILenraOperation.remove;
      case "replace":
        return UILenraOperation.replace;
      default:
        return null;
    }
  }

  bool isInteger() {
    if (this == null) {
      return false;
    }
    return int.tryParse(this) != null;
  }
}

class UiPatchEvent {
  String id;
  UILenraOperation operation;
  String property;
  dynamic value;
  int childIndex;

  UiPatchEvent(
    this.id,
    this.operation,
    this.property,
    this.value,
    this.childIndex,
  );
}
