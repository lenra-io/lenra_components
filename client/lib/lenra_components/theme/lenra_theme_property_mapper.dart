class LenraThemePropertyMapper<T, D> {
  T Function(D) resolver;

  T resolve(D property) {
    return resolver(property);
  }

  LenraThemePropertyMapper.all(T value) {
    this.resolver = (D property) => value;
  }

  LenraThemePropertyMapper.resolveWith(this.resolver);
}
