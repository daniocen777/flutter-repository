import 'dart:io';

import 'package:currencyapp/src/provider/rest_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  /* Latest 47 */
  test(
      'Latest api debe retornar los símbolo con sus respectivos tipos de cambio',
      () async {
    final provider = _getProvider('test/provider_test/latest.json');
    final result = await provider.latest();
    final currency = result.item1;
    final timestamp = result.item2;

    expect(currency.length, 3);
    expect(timestamp, 1519296206);
    expect(currency['GBP'], 0.72007);
  });
}

RestProvider _getProvider(String filePath) =>
    RestProvider(httpClient: _getMockprovider(filePath));

final header = {
  HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
};

MockClient _getMockprovider(String filePath) => MockClient((_) async =>
    Response(await File(filePath).readAsString(), 200, headers: header));
