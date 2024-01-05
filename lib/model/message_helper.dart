class MessageHelper {
  final String uId;
  final String uEmail;
  final String threadId;
  final String message;

  MessageHelper(
      {required this.uId,
      required this.uEmail,
      required this.threadId,
      required this.message});

  Map<String, dynamic> toMap() {
    return {
      'user_id': uId,
      'user_email': uEmail,
      'thread_id': threadId,
      'message': message
    };
  }
}
