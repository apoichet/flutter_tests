import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests/traveler/logic/traveler_description/traveler_description_cubit.dart';
import 'package:flutter_tests/traveler/logic/traveler_description/traveler_description_state.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_bloc.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_state.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';
import 'package:flutter_tests/traveler/ui/screen/add_traveler_screen.dart';
import 'package:flutter_tests/traveler/ui/screen/add_traveler_success_screen.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../golden_helper.dart';
import '../../logic/traveler_description/traveler_description_cubit_test.dart';

class TravelerDescriptionCubitMock extends MockCubit<TravelerDescriptionState>
    implements TravelerDescriptionCubit {}

class TravelerDescriptionStateFake extends Fake
    implements TravelerDescriptionState {}

class NavigatorObserverMock extends Mock implements NavigatorObserver {}

class RouteFake extends Fake implements Route {}

void main() {
  late TravelerDescriptionCubit travelerDescriptionCubitMock;
  late TravelerFormBloc travelerFormBlocMock;
  late Widget widget;
  late NavigatorObserver navigatorObserverMock;

  setUpAll(() {
    registerFallbackValue(TravelerDescriptionStateFake());
    registerFallbackValue(TravelerFormStateFake());
    registerFallbackValue(TravelerFormEventFake());
    registerFallbackValue(RouteFake());
  });

  setUp(() {
    travelerDescriptionCubitMock = TravelerDescriptionCubitMock();
    travelerFormBlocMock = TravelerFormBlocMock();
    navigatorObserverMock = NavigatorObserverMock();
    widget = MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => travelerFormBlocMock,
          ),
          BlocProvider(create: (_) => travelerDescriptionCubitMock)
        ],
        child: MaterialApp(
          home: AddTraveler(),
          navigatorObservers: [navigatorObserverMock],
          debugShowCheckedModeBanner: false,
        ));
  });

  group('$AddTravelerScreen Widget Tests', () {
    group('build state', () {
      testWidgets('$AddTravelerLoading should show $CircularProgressIndicator',
          (WidgetTester tester) async {
        final traveler = Traveler(type: TravelerType.ADULT);
        when(() => travelerFormBlocMock.state)
            .thenReturn(AddTravelerLoading(traveler));
        when(() => travelerDescriptionCubitMock.state)
            .thenReturn(TravelerDescriptionState(TravelerDescription.ADULT));

        await tester.pumpWidget(widget);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('$TravelerFormClean should clear form',
          (WidgetTester tester) async {
        final traveler = Traveler(
            firstName: "firstName",
            lastName: "lastName",
            age: "22",
            type: TravelerType.YOUNG);
        whenListen(travelerFormBlocMock, Stream.value(TravelerFormClean()),
            initialState: TravelerFormUpdate(traveler));

        when(() => travelerDescriptionCubitMock.state)
            .thenReturn(TravelerDescriptionState(TravelerDescription.ADULT));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.text("firstName"), findsNothing);
        expect(find.text("lastName"), findsNothing);
        expect(find.text("22"), findsNothing);
        expect(find.text(TravelerDescription.ADULT), findsOneWidget);
      });
    });

    group('listen state', () {
      testWidgets(
          '$AddTravelerSuccess should navigate to $AddTravelerSuccessScreen',
          (WidgetTester tester) async {
        when(() => travelerDescriptionCubitMock.state)
            .thenReturn(TravelerDescriptionState(TravelerDescription.ADULT));

        final traveler = Traveler(type: TravelerType.ADULT);
        whenListen(
            travelerFormBlocMock, Stream.value(AddTravelerSuccess(traveler)),
            initialState: AddTravelerInitial());

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        verify(() => navigatorObserverMock.didPush(any(), any()));
        expect(find.byType(AddTraveler), findsNothing);
        expect(find.byType(AddTravelerSuccessScreen), findsOneWidget);
      });

      testWidgets('$AddTravelerError should show snack bar with error msg',
          (WidgetTester tester) async {
        when(() => travelerDescriptionCubitMock.state)
            .thenReturn(TravelerDescriptionState(TravelerDescription.ADULT));

        final traveler = Traveler(type: TravelerType.ADULT);
        whenListen(
            travelerFormBlocMock,
            Stream.value(
                AddTravelerError(traveler: traveler, msgError: "Error")),
            initialState: AddTravelerInitial());

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.byType(AddTraveler), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text("Error"), findsOneWidget);
      });
    });
  });

  group('$AddTravelerScreen Golden Tests', () {
    testGoldens('$AddTravelerInitial state', (tester) async {
      when(() => travelerFormBlocMock.state).thenReturn(AddTravelerInitial());
      when(() => travelerDescriptionCubitMock.state)
          .thenReturn(TravelerDescriptionState(TravelerDescription.ADULT));

      await tester.pumpWidgetBuilder(widget);

      await multiScreenGolden(
        tester,
        'add_traveler',
        devices: GoldenSizeHelper.screens,
        autoHeight: true,
      );

      await tester.pumpWidgetBuilder(MaterialGolden(child: widget));

      await multiScreenGolden(
        tester,
        'add_traveler',
        devices: [GoldenSizeHelper.semanticsScreen],
        autoHeight: true,
      );
    });
  });
}
