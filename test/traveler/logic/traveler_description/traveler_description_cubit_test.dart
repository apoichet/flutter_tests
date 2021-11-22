import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests/traveler/logic/traveler_description/traveler_description_cubit.dart';
import 'package:flutter_tests/traveler/logic/traveler_description/traveler_description_state.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_bloc.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_event.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_state.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';
import 'package:mocktail/mocktail.dart';

class TravelerFormBlocMock extends MockBloc<TravelerFormEvent, TravelerFormState> implements TravelerFormBloc {}

class TravelerFormStateFake extends Fake implements TravelerFormState {}

class TravelerFormEventFake extends Fake implements TravelerFormEvent {}

void main() {
  late TravelerFormBloc travelerFormBlocMock;
  late TravelerDescriptionCubit cubit;

  setUp(() {
    travelerFormBlocMock = TravelerFormBlocMock();
    cubit = TravelerDescriptionCubit(
      initialTravelerType: TravelerType.BABY,
      travelerFormBloc: travelerFormBlocMock,
    );
  });

  setUpAll(() {
    registerFallbackValue(TravelerFormStateFake());
    registerFallbackValue(TravelerFormEventFake());
  });

  tearDownAll(() {
    cubit.close();
  });

  blocTest<TravelerDescriptionCubit, TravelerDescriptionState>(
    '$TravelerDescriptionCubit emits new state with corresponding description from traveler type',
    build: () => cubit,
    act: (_) {
      cubit.newDescriptionFrom(TravelerType.BABY);
      cubit.newDescriptionFrom(TravelerType.YOUNG);
      cubit.newDescriptionFrom(TravelerType.ADULT);
      cubit.newDescriptionFrom(TravelerType.SENIOR);
    },
    expect: () => [
      TravelerDescriptionState(TravelerDescription.BABY),
      TravelerDescriptionState(TravelerDescription.YOUNG),
      TravelerDescriptionState(TravelerDescription.ADULT),
      TravelerDescriptionState(TravelerDescription.SENIOR),
    ],
    verify: (_) => verify(
      () => travelerFormBlocMock.stream.listen(
        (event) => cubit.newDescriptionFrom(event.traveler.type),
      ),
    ),
  );
}
