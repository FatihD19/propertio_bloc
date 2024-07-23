import 'package:flutter/material.dart';
import 'package:propertio_bloc/constants/theme.dart';
import 'package:propertio_bloc/shared/utils.dart';

class TextPrice extends StatelessWidget {
  String price;
  TextPrice(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(formatCurrency(price),
        style: thirdTextStyle.copyWith(fontWeight: bold, fontSize: 16));
  }
}
