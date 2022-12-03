import 'package:flutter/material.dart';

class CustomText extends Text{
  const CustomText(super.data, {super.key});

  @override
  String? get data => '${super.data} UZS';


}