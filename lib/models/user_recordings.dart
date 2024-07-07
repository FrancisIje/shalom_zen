class RecordingConst {
  static const title = "title";
  static const downloadUrl = "downloadUrl";
}

class UserRecordings {
  String title;
  String downnloadUrl;

  UserRecordings({required this.title, required this.downnloadUrl});

  factory UserRecordings.fromMap(Map<String, dynamic> data) {
    return UserRecordings(
        title: data[RecordingConst.title],
        downnloadUrl: data[RecordingConst.downloadUrl]);
  }

  Map<String, dynamic> toMap() {
    return {
      RecordingConst.title: title,
      RecordingConst.downloadUrl: downnloadUrl
    };
  }
}
