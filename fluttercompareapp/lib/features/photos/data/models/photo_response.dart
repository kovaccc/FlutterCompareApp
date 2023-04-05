import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_response.g.dart';

@JsonSerializable()
class PhotoResponse {
  
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
  
  const PhotoResponse({ 
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoResponse.fromJson(Map<String, dynamic> json) => _$PhotoResponseFromJson(json);
}
