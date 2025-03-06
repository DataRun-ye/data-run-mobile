typedef AsyncValueGetter<T> = Future<T> Function();

class Lazy<T> {
  Lazy(this._asyncLoad);

  final AsyncValueGetter<T> _asyncLoad;
  bool _isLoaded = false;

  late final T _value;

  bool get isLoaded => _isLoaded;

  Future<T> call() async => _isLoaded ? _value : await _loadValue();

  Future<T> _loadValue() async {
    _value = await _asyncLoad();
    _isLoaded = true;
    return _value;
  }
}
