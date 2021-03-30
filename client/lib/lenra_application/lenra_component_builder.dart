abstract class LenraComponentBuilder<T> {
  T build(Map<Symbol, dynamic> parsedProps) {
    return Function.apply(this.map, [], parsedProps);
  }

  T map();

  Map<String, String> get propsTypes;
}
