import 'package:flutter/material.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/container_style.dart';

class PromoArApp extends StatelessWidget {
  const PromoArApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: customBoxDecoration(),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Augmented Reality (AR) Apps ',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 8),
          Text(
            'Unduh aplikasi AR kami melalui Google Play dan rasakan pengalaman tak terlupakan.',
            style: primaryTextStyle.copyWith(fontSize: 12),
          ),
          SizedBox(height: 8),
          Center(child: Image.asset('assets/img_getOn_playstore.png'))
        ],
      ),
    );
  }
}
