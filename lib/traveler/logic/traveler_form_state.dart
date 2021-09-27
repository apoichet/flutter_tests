import 'package:equatable/equatable.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';

Traveler _initTraveler = Traveler(type: TravelerType.ADULT);

abstract class TravelerFormState extends Equatable {
  final Traveler traveler;

  TravelerFormState(this.traveler);

  @override
  List<Object?> get props => [traveler];
}

class AddTravelerInitial extends TravelerFormState {
  AddTravelerInitial() : super(_initTraveler);
}

class AddTravelerSuccess extends TravelerFormState {
  AddTravelerSuccess(Traveler traveler) : super(traveler);
}

class AddTravelerError extends TravelerFormState {
  final String msgError;

  AddTravelerError({required Traveler traveler, required this.msgError}) : super(traveler);

  @override
  List<Object?> get props => [traveler, msgError];
}

class AddTravelerLoading extends TravelerFormState {
  AddTravelerLoading(Traveler traveler) : super(traveler);
}

class TravelerFormUpdate extends TravelerFormState {
  TravelerFormUpdate(Traveler traveler) : super(traveler);
}

class TravelerFormClean extends TravelerFormState {
  TravelerFormClean() : super(_initTraveler);
}
