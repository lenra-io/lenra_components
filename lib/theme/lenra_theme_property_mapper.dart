class LenraThemePropertyMapper<T, D> {
  late T Function(D) resolver;

  T resolve(D property) {
    return resolver(property);
  }

  LenraThemePropertyMapper.all(T value) {
    resolver = (D property) => value;
  }

  LenraThemePropertyMapper.resolveWith(this.resolver);
}
