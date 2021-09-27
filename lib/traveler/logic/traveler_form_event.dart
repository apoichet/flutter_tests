import 'package:flutter_tests/traveler/model/traveler.dart';

abstract class TravelerFormEvent {}

class AddTravelerEvent extends TravelerFormEvent {
  final Traveler traveler;
  AddTravelerEvent(this.traveler);
}

class ClearTravelerEvent extends TravelerFormEvent {
  final Traveler travelerToClear;
  ClearTravelerEvent(this.travelerToClear);
}
