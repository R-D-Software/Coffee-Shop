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

  @override
  final definitionType = BarionApiService;

  @override
  Future<Response<BuiltBarionStartResponse>> postBarionPayment(
      BuiltBarionPayment body) {
    final $url = '/v2/Payment/Start';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<BuiltBarionStartResponse, BuiltBarionStartResponse>($request);
  }

  @override
  Future<Response> getPaymentState(String POSKey, String PaymentId) {
    final $url = '/v2/Payment/GetPaymentState';
    final $params = <String, dynamic>{'POSKey': POSKey, 'PaymentId': PaymentId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
