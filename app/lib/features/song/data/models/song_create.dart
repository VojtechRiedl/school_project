class SongCreateModel {
  final String title;
  final String ? youtubeLink;
  final String ? text;
  final int user;

  SongCreateModel({
    required this.title,
    this.youtubeLink,
    this.text,
    required this.user,
  });


  Map<String, dynamic> toJson() {
    return {
      'name': title,
      'yt_link': youtubeLink,
      'text': text,
      'user_id': user,
    };
  }



}