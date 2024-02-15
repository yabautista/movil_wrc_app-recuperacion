import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movil_wrc_app/responseTypes/drivers_response.dart';

final dioProvider = Provider<Dio>((ref) => Dio());
final getDrivers = FutureProvider.autoDispose((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get('https://api.wrc.com/content/driver?class=WRC',
      options: Options(
        validateStatus: (status) => status! < 500,
      ));
  final driver = DriversResponse.fromJson(response.data);
  return driver;
});
