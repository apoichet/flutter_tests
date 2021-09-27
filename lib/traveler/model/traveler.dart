import 'package:equatable/equatable.dart';

class Traveler extends Equatable {
  final String firstName;
  final String lastName;
  final String age;
  final TravelerType type;

  Traveler({this.firstName = "", this.lastName = "", this.age = "", required this.type});

  @override
  List<Object?> get props => [firstName, lastName, age, type];
}

enum TravelerType { BABY, YOUNG, ADULT, SENIOR }

extension TravelerTypeToString on TravelerType {
  String toShortString() {
    switch (this) {
      case TravelerType.BABY:
        return 'Baby';
      case TravelerType.SENIOR:
        return 'Senior';
      case TravelerType.ADULT:
        return 'Adult';
      case TravelerType.YOUNG:
        return 'Young';
      default:
    }

    return this.toString().split('.').last;
  }
}

class TravelerDescription {
  static const BABY =
      "A baby is considered a passenger from 0 to 3 years old, you can decide to reserve a place for him which will therefore cost an additional charge. You can also decide to have it travel on your genus, which will be free.";
  static const CHILD = "Children are 4 to 12 years old and must be accompanied by an adult, they cannot travel alone.";
  static const SENIOR =
      "Seniors are passengers over 60 years old, they can benefit from a reduction card and thus benefit from advantageous traffic.";
  static const ADULT =
      "Adults are passengers between 28 and 60 years old, they have the possibility of having a weekend card which gives the right to some reductions according to the conditions of the trip.";
  static const YOUNG =
      "The so-called young passengers are between 12 and 28 years old, there are several reduction cards including the youth advantage card which allows occasional discounts but also the TGV Max card which in the form of a subscription, which allows free travel on TGVs subject to availability.";
}
