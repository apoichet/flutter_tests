import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_event.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_state.dart';
import 'package:flutter_tests/traveler/repository/traveler_repository_fake.dart';

class TravelerFormBloc extends Bloc<TravelerFormEvent, TravelerFormState> {
  final TravelerRepositoryFake repository;

  TravelerFormBloc(this.repository) : super(AddTravelerInitial());

  @override
  Stream<TravelerFormState> mapEventToState(TravelerFormEvent event) async* {
    if (event is AddTravelerEvent) {
      yield AddTravelerLoading(event.traveler);
      final TravelerRepositoryResponse response = await repository.addTraveler(event.traveler);
      if (response.error != null) {
        yield AddTravelerError(
          traveler: event.traveler,
          msgError: response.error!.msg,
        );
      } else {
        yield AddTravelerSuccess(event.traveler);
      }
    }
    if (event is ClearTravelerEvent) {
      yield TravelerFormUpdate(event.travelerToClear);
      yield TravelerFormClean();
    }
  }
}
