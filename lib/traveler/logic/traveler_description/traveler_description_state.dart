import 'package:equatable/equatable.dart';

class TravelerDescriptionState extends Equatable {
  final String description;

  TravelerDescriptionState(this.description);

  @override
  List<Object?> get props => [description];
}
