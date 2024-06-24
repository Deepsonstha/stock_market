// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppErrorHandler {
  final String message;

  AppErrorHandler({
    required this.message,
  });

  AppErrorHandler copyWith({
    String? message,
  }) {
    return AppErrorHandler(
      message: message ?? this.message,
    );
  }

  @override
  String toString() => 'AppErrorHandler(message: $message)';

  @override
  bool operator ==(covariant AppErrorHandler other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
