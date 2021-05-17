class Arguments {
  final Map<String, dynamic> params;
  final Uri? uri;
  final dynamic? data;

  const Arguments({this.params = const {}, this.data, this.uri});

  Arguments copyWith({Map<String, dynamic>? params, dynamic? data, Uri? uri}) {
    return Arguments(
      params: params ?? this.params,
      data: data ?? this.data,
      uri: uri ?? this.uri,
    );
  }

  Map<String, String> get queryParams => uri?.queryParameters ?? {};
}
