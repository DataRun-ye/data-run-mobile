sealed class NetworkResponse<Model> {
  const NetworkResponse._();

  factory NetworkResponse.noData(String errorText) = NoData;

  factory NetworkResponse.ok(Model data) = Ok;

  factory NetworkResponse.invalidParameters(String message) = InvalidParameters;

  factory NetworkResponse.noAuth(String message) = NoAuth;

  factory NetworkResponse.noAccess(String message) = NoAccess;

  factory NetworkResponse.badRequest(String message) = BadRequest;

  factory NetworkResponse.notFound(String message) = NotFound;

  factory NetworkResponse.conflict(String message) = Conflict;
}

class Ok<Model> extends NetworkResponse<Model> {
  final Model data;

  Ok(this.data) : super._();
}

class InvalidParameters<Model> extends NetworkResponse<Model> {
  final String message;

  InvalidParameters(this.message) : super._();
}

class NoAuth<Model> extends NetworkResponse<Model> {
  final String message;

  NoAuth(this.message) : super._();
}

class NoAccess<Model> extends NetworkResponse<Model> {
  final String message;

  NoAccess(this.message) : super._();
}

class BadRequest<Model> extends NetworkResponse<Model> {
  final String message;

  BadRequest(this.message) : super._();
}

class NotFound<Model> extends NetworkResponse<Model> {
  final String message;

  NotFound(this.message) : super._();
}

class Conflict<Model> extends NetworkResponse<Model> {
  final String message;

  Conflict(this.message) : super._();
}

class NoData<Model> extends NetworkResponse<Model> {
  final String message;

  NoData(this.message) : super._();
}
