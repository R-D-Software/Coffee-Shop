import 'package:chopper/chopper.dart';
import 'package:coffee_shop/Models/Barion/barion_payment.dart';
import 'package:coffee_shop/Models/Barion/barion_start_response.dart';

import 'built_value_converter.dart';

part 'barion_api_service.chopper.dart';

@ChopperApi(baseUrl: '/v2/Payment')
abstract class BarionApiService extends ChopperService {
  @Post(path: "/Start")
  Future<Response<BuiltBarionStartResponse>> postBarionPayment(
    @Body() BuiltBarionPayment body,
  );

  @Get(path: "/GetPaymentState")
  Future<Response> getPaymentState(@Query('POSKey') String POSKey, @Query('PaymentId') String PaymentId);

  static BarionApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://api.test.barion.com',
      services: [
        _$BarionApiService(),
      ],
      converter: BuiltValueConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$BarionApiService(client);
  }
}
