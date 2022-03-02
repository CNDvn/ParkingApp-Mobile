class ValidationItem {
  String? value;
  String? error;
  ValidationItem(this.value, this.error);

  @override
  String toString() => 'ValidationItem(value: $value, error: $error)';
}
