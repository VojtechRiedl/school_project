class SongUpdateModel {
  final String title;
  final String ? youtubeLink;
  final String ? text;

  SongUpdateModel({
    required this.title,
    this.youtubeLink,
    this.text,
  });


  Map<String, dynamic> toJson() {
    return {
      'name': title,
      'yt_link': youtubeLink,
      'text': text,
    };
  }

}