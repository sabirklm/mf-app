class CustomException implements Exception {
  final String message;
  final String? logs;
  final int? code;

  CustomException(this.message, {this.code, this.logs});

  @override
  String toString() {
    return 'CustomException: $message (code: $code)';
  }
}
