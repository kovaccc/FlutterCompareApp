import 'package:equatable/equatable.dart';

class User extends Equatable {
  
  final String id;

  const User({ 
    required this.id,
  });

  
  User copyWith({ 
    String? id,
  }) {
    return User(
      id: id ?? this.id,
    );
  }
  @override
  List<Object?> get props => [
        id,
      ];
}
