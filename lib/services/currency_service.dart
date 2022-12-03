import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_nbu_api_data/models/currency_model.dart';

class CurrencyService{

  static Future<List<CurrencyModel>> getCurrencies() async {
    const baseUrl = 'https://nbu.uz';
    try{
      Response res = await Dio().get('$baseUrl/exchange-rates/json/');

      switch (res.statusCode) {
        case HttpStatus.ok:
          if (res.data is List) {
            return (res.data as List).map(
                  (e) {
                return CurrencyModel.fromJson(e);
              },
            ).toList();
          }
          return [].cast<CurrencyModel>();

        default:
          return [].cast<CurrencyModel>();
      }
      
    }catch(e){
      if(e is DioError){
        print('${e.response!.data}');
      }
      throw Exception('ERROR While Getting Datas From Api');
    }
  }
}