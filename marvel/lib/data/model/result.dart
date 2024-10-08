class Response<T> {
  final int code;
  final String status;
  final String etag;
  final Data<T> data;

  Response(
      {required this.code,
      required this.status,
      required this.etag,
      required this.data});
}

class Data<T> {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<T> resuls;

  Data(
      {required this.offset,
      required this.limit,
      required this.total,
      required this.count,
      required this.resuls});
}
