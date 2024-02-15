import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:movil_wrc_app/responseTypes/calendar_response.dart';
final dioProvider = Provider<Dio>((ref) => Dio());
final getCalendar = FutureProvider.autoDispose((ref) async{
  final dio = ref.watch(dioProvider);
  final response = await dio.get(
    'https://api.wrc.com/content/filters/calendar?championship=wrc&origin=vcms&year=2024',
    options:Options(
      validateStatus: (status) => status! < 500,
    )
  );
  final calendar = CalendarResponse.fromJson(response.data);
  return calendar;
});