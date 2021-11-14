import 'package:test/test.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';
import 'package:flutter_tests/traveler/repository/traveler_repository_fake.dart';

void main() {
  late TravelerRepositoryFake repository;

  setUpAll(() {
    repository = TravelerRepositoryFake();
  });

  group('$TravelerRepositoryFake', () {
    group('should raised $TravelerRepositoryResponseError', () {
      test('with Technical Error when traveler age is negative', () async {
        //Given
        final travelerError = _givenTravelerWithAge(-12);
        //When
        final response = await repository.addTraveler(travelerError);
        //Then
        expect(response.error?.msg, 'Technical Error');
        expect(response.success, isNull);
      });

      test('with Technical Error when traveler age is 0', () async {
        //Given
        final travelerError = _givenTravelerWithAge(0);
        //When
        final response = await repository.addTraveler(travelerError);
        //Then
        expect(response.error?.msg, 'Technical Error');
        expect(response.success, isNull);
      });

      test('with Functional Error when traveler is YOUNG and age is more than 27', () async {
        //Given
        final travelerError = Traveler(age: "28", type: TravelerType.YOUNG);
        //When
        final response = await repository.addTraveler(travelerError);
        //Then
        expect(response.error?.msg, 'Functional Error');
        expect(response.success, isNull);
      });

      test('with Functional Error when traveler is YOUNG and age is 27', () async {
        //Given
        final travelerError = Traveler(age: "27", type: TravelerType.YOUNG);
        //When
        final response = await repository.addTraveler(travelerError);
        //Then
        expect(response.error?.msg, 'Functional Error');
        expect(response.success, isNull);
      });
    });

    test('should return $TravelerRepositoryResponseSuccess with traveler when add traveler with success', () async {
      //Given
      final travelerSuccess = Traveler(
        type: TravelerType.YOUNG,
        age: "26",
        firstName: "alexandre",
        lastName: "poichet",
      );
      //When
      final response = await repository.addTraveler(travelerSuccess);
      //Then
      expect(response.success?.traveler, travelerSuccess);
      expect(response.error, isNull);
    });
  });
}

Traveler _givenTravelerWithAge(int age) => Traveler(age: age.toString(), type: TravelerType.ADULT);
