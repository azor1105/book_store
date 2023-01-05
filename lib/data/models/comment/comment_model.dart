class CommentModel {
  String id;
  String createdAt;
  String userDocId;
  String message;

  CommentModel({
    required this.createdAt,
    required this.id,
    required this.message,
    required this.userDocId,
  });

  factory CommentModel.fromJson({
    required Map<String, dynamic> json,
    required String docId,
  }) =>
      CommentModel(
        createdAt: json['createdAt'] as String? ?? '',
        id: docId,
        message: json['message'] as String? ?? '',
        userDocId: json['userDocId'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'userDocId': userDocId,
        'message': message,
      };
}
