import 'package:flutter/material.dart';

class CurrencyModel {
  String title;
  String code;
  String cbPrice;
  String nbuBuyPrice;
  String nbuCellPrice;
  String date;
  bool isSelected = false;

  CurrencyModel({
    required this.title,
    required this.code,
    required this.cbPrice,
    required this.nbuBuyPrice,
    required this.nbuCellPrice,
    required this.date,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      title: json['title'] as String? ?? '',
      code: json['code'] as String? ?? '',
      cbPrice: json['cb_price'] as String? ?? '',
      nbuBuyPrice: json['nbu_buy_price'] as String? ?? '',
      nbuCellPrice: json['nbu_cell_price'] as String? ?? '',
      date: json['date'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['code'] = code;
    data['cb_price'] = cbPrice;
    data['nbu_buy_price'] = nbuBuyPrice;
    data['nbu_cell_price'] = nbuCellPrice;
    data['date'] = date;
    return data;
  }
}
