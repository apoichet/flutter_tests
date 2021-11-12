import 'package:flutter_tests/traveler/model/traveler.dart';

const INTEGRATION_TEST = bool.fromEnvironment('INTEGRATION_TEST');
var stubNbError = 0;

class TravelerRepositoryFake {
  Future<TravelerRepositoryResponse> addTraveler(Traveler traveler) {

    return Future.delayed(Duration(seconds: 1)).then((_) {

      if(int.parse(traveler.age) <= 0) {
        return TravelerRepositoryResponse(error: TravelerRepositoryResponseError("Technical Error"));
      }

      if(traveler.type == TravelerType.YOUNG && int.parse(traveler.age) >= 27) {
        return TravelerRepositoryResponse(error: TravelerRepositoryResponseError("Functional Error"));
      }

      return TravelerRepositoryResponse(success: TravelerRepositoryResponseSuccess(traveler));

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
