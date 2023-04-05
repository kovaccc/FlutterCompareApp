import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final int id;
  final String title;
  final String url;

  const Photo({
    required this.id,
    required this.title,
    required this.url,
  });

  Photo copyWith({
    int? id,
    String? title,
    String? url,
  }) {
    return Photo(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        url,
      ];
}
