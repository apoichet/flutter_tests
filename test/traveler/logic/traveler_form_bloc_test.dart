import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_bloc.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_event.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_state.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';
import 'package:flutter_tests/traveler/repository/traveler_repository_fake.dart';
import 'package:mocktail/mocktail.dart';

class TravelerRepositoryMock extends Mock implements TravelerRepositoryFake {}

class _TravelerFake extends Fake implements Traveler {}

void main() {
  late TravelerFormBloc bloc;
  late TravelerRepositoryFake travelerRepositoryMock;

  setUp(() {
    travelerRepositoryMock = TravelerRepositoryMock();
    bloc = TravelerFormBloc(travelerRepositoryMock);
  });

  tearDownAll(() {
    bloc.close();
  });

  void _mockRepositoryResponse({required Traveler traveler, required bool success}) {
    when(() => travelerRepositoryMock.addTraveler(traveler)).thenAnswer((_) async => success
        ? TravelerRepositoryResponse(success: TravelerRepositoryResponseSuccess(traveler))
        : TravelerRepositoryResponse(error: TravelerRepositoryResponseError("Error")));
  }

  void _mockRepositoryResponseSuccess(Traveler traveler) => _mockRepositoryResponse(traveler: traveler, success: true);

  void _mockRepositoryResponseError(Traveler traveler) => _mockRepositoryResponse(traveler: traveler, success: false);

  test('Initial state is $AddTravelerInitial with $TravelerType ADULT', () {
    expect(bloc.state, AddTravelerInitial());
    expect(bloc.state.traveler, Traveler(type: TravelerType.ADULT));
  });

  group('$TravelerFormBloc receives $AddTravelerEvent', () {
    final travelerFake = _TravelerFake();

    blocTest<TravelerFormBloc, TravelerFormState>(
      'emits [$AddTravelerLoading, $AddTravelerSuccess] when add traveler with success',
      build: () => bloc,
      act: (bloc) {
        _mockRepositoryResponseSuccess(travelerFake);
        bloc.add(AddTravelerEvent(travelerFake));
      },
      expect: () => [AddTravelerLoading(travelerFake), AddTravelerSuccess(travelerFake)],
    );

    blocTest<TravelerFormBloc, TravelerFormState>(
      'emits [$AddTravelerLoading, $AddTravelerError] when add traveler with error',
      build: () => bloc,
      act: (bloc) {
        _mockRepositoryResponseError(travelerFake);
        bloc.add(AddTravelerEvent(travelerFake));
      },
      expect: () => [AddTravelerLoading(travelerFake), AddTravelerError(traveler: travelerFake, msgError: "Error")],
    );
  });

  group('$TravelerFormBloc receives $ClearTravelerEvent', () {
    final travelerFake = _TravelerFake();

    blocTest<TravelerFormBloc, TravelerFormState>(
        'emits [$TravelerFormUpdate, $TravelerFormClean] when clear traveler form',
        build: () => bloc,
        act: (bloc) {
          bloc.add(ClearTravelerEvent(travelerFake));
        },
        expect: () => [TravelerFormUpdate(travelerFake), TravelerFormClean()],
        verify: (bloc) => expect(bloc.state.traveler, Traveler(type: TravelerType.ADULT)));
  });
}
