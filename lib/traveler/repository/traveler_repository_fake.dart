import 'package:flutter_tests/traveler/model/traveler.dart';

const INTEGRATION_TEST = bool.fromEnvironment('INTEGRATION_TEST');
var stubNbError = 0;

class TravelerRepositoryFake {
  Future<TravelerRepositoryResponse> addTraveler(Traveler traveler) {
    return Future.delayed(Duration(seconds: 1)).then((_) {
      if(INTEGRATION_TEST) {
        return TravelerRepositoryResponse(success: TravelerRepositoryResponseSuccess(traveler));
      } else if (stubNbError == 0) {
        stubNbError++;
        return TravelerRepositoryResponse(error: TravelerRepositoryResponseError("Technical Error"));
      } else if (stubNbError == 1) {
        stubNbError++;
        return TravelerRepositoryResponse(error: TravelerRepositoryResponseError("Functional Error"));
      } else {
        return TravelerRepositoryResponse(success: TravelerRepositoryResponseSuccess(traveler));
      }
    });
  }
}

class TravelerRepositoryResponse {
  TravelerRepositoryResponseSuccess? success;
  TravelerRepositoryResponseError? error;

  TravelerRepositoryResponse({this.error, this.success});
}

class TravelerRepositoryResponseSuccess {
  Traveler traveler;

  TravelerRepositoryResponseSuccess(this.traveler);
}

class TravelerRepositoryResponseError {
  String msg;

  TravelerRepositoryResponseError(this.msg);
}
