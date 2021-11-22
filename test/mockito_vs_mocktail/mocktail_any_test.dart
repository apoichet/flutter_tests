import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'foo_service.dart';

class FooRepositoryMock extends Mock implements FooRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(Foo());
  });

  test('should verify to use foo repository', () {
    final fooRepositoryMock = FooRepositoryMock();
    final fooService = FooService(fooRepositoryMock);
    final foo = Foo();

    when(
      () => fooRepositoryMock.fooRepositoryFunction(
        any(),
        any(),
        requiredFooNamed: any(named: 'requiredFooNamed'),
        nullableFooNamed: any(named: 'nullableFooNamed'),
      ),
    ).thenReturn(foo);

    final result = fooService.fooServiceFunction(foo, foo, requiredFooNamed: foo, nullableFooNamed: foo);

    expect(result, foo);
    verify(() => fooRepositoryMock.fooRepositoryFunction(foo, foo, requiredFooNamed: foo, nullableFooNamed: foo));
  });
}
