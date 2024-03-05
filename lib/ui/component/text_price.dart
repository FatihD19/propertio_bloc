import 'package:flutter/material.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/shared/utils.dart';

class TextPrice extends StatelessWidget {
  String price;
  TextPrice(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(formatCurrency(price),
        style: thirdTextStyle.copyWith(fontWeight: bold, fontSize: 16));
  }
}
