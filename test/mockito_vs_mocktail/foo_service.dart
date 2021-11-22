class FooService {
  final FooRepository _repository;

  FooService(FooRepository repository) : _repository = repository;

  Foo fooServiceFunction(
    Foo requiredFoo,
    Foo? nullableFoo, {
    Foo? nullableFooNamed,
    required requiredFooNamed,
  }) =>
      _repository.fooRepositoryFunction(
        requiredFoo,
        nullableFoo,
        nullableFooNamed: nullableFooNamed,
        requiredFooNamed: requiredFooNamed,
      );
}

class FooRepository {
  Foo fooRepositoryFunction(
    Foo requiredFoo,
    Foo? nullableFoo, {
    Foo? nullableFooNamed,
    required requiredFooNamed,
  }) =>
      requiredFoo;
}

class Foo {}
