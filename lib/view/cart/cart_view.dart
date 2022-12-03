import 'package:flutter/material.dart';
import 'package:get_nbu_api_data/provider/currencies_provider.dart';
import 'package:get_nbu_api_data/view/cart/cart_view_model.dart';
import 'package:provider/provider.dart';

class CartView extends CartViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Center: ${context.watch<CurrenciesProvider>().totalSum}',
          style: const TextStyle(color: Colors.black, fontSize: 32),
        ),
      ),
    );
  }
}
