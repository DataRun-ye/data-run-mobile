sealed class NetworkRequestBody {}

class Empty extends NetworkRequestBody {}

class Json extends NetworkRequestBody {
  final Map<String, dynamic> data;

  Json(this.data);
}

class Text extends NetworkRequestBody {
  final String data;

  Text(this.data);
}
