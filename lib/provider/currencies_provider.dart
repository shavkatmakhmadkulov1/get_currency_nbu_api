import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_nbu_api_data/models/currency_model.dart';
import 'package:get_nbu_api_data/services/currency_service.dart';

class CurrenciesProvider extends ChangeNotifier {
  CurrenciesProvider() {
    getCurrencies();
  }

  List<CurrencyModel> currencies = [];
  bool isLoading = false;
  double totalSum = 0;

  void checkTotalSum() {
    for (var currency in currencies) {
      totalSum += double.parse(currency.cbPrice).floor();
      currency.isSelected = true;
    }
    notifyListeners();
  }

  getCurrencies() async {
    changeLoading();
    CurrencyService.getCurrencies().then((value) async {
      await Future.delayed(const Duration(seconds: 3));
      currencies = value;
      changeLoading();
    });
  }

  changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}

