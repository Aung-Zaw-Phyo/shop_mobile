import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final int id;
  final String name;

  const ImageEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
