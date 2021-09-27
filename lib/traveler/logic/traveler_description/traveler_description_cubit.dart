import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tests/traveler/logic/traveler_description/traveler_description_state.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_bloc.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_state.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';

class TravelerDescriptionCubit extends Cubit<TravelerDescriptionState> {
  final TravelerFormBloc travelerFormBloc;

  late StreamSubscription<TravelerFormState> _travelerFormStreamSubscription;

  factory TravelerDescriptionCubit(
      {required TravelerType initialTravelerType, required TravelerFormBloc travelerFormBloc}) {
    TravelerDescriptionState initialState = _getDescriptionState(initialTravelerType);
    return TravelerDescriptionCubit._(initialState: initialState, travelerFormBloc: travelerFormBloc);
  }

  TravelerDescriptionCubit._({required TravelerDescriptionState initialState, required this.travelerFormBloc})
      : super(initialState) {
    _travelerFormStreamSubscription =
        travelerFormBloc.stream.listen((event) => newDescriptionFrom(event.traveler.type));
  }

  @override
  Future<void> close() {
    _travelerFormStreamSubscription.cancel();
    return super.close();
  }

  void newDescriptionFrom(TravelerType type) {
    emit(_getDescriptionState(type));
  }

  static TravelerDescriptionState _getDescriptionState(TravelerType type) {
    var description = "";
    switch (type) {
      case TravelerType.ADULT:
        description = TravelerDescription.ADULT;
        break;
      case TravelerType.YOUNG:
        description = TravelerDescription.YOUNG;
        break;
      case TravelerType.BABY:
        description = TravelerDescription.BABY;
        break;
      case TravelerType.SENIOR:
        description = TravelerDescription.SENIOR;
    }
    return TravelerDescriptionState(description);
  }
}
