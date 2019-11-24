// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barion_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$BarionApiService extends BarionApiService {
  _$BarionApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = BarionApiService;

  Future<Response<BuiltBarionStartResponse>> postBarionPayment(
      BuiltBarionPayment body) {
    final $url = '/v2/Payment/Start';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<BuiltBarionStartResponse, BuiltBarionStartResponse>($request);
  }

  Future<Response> getPaymentState(String POSKey, String PaymentId) {
    final $url = '/v2/Payment/GetPaymentState';
    final Map<String, dynamic> $params = {
      'POSKey': POSKey,
      'PaymentId': PaymentId
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
