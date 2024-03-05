import 'package:flutter/material.dart';
import 'package:propertio_mobile/shared/theme.dart';

class ItemTipeApartemen extends StatelessWidget {
  String location;
  String jumlah;
  ItemTipeApartemen(this.location, this.jumlah, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 126,
          height: 208,
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/img_tipe_apart.png')),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Positioned(
            top: 9,
            left: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location,
                    style: buttonTextStyle.copyWith(
                        fontWeight: bold, fontSize: 12)),
                Text(jumlah + ' Apartemen',
                    style: buttonTextStyle.copyWith(fontSize: 8)),
              ],
            )),
      ],
    );
  }
}
