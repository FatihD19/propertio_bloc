import 'package:flutter/material.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/search_form.dart';
import 'package:propertio_mobile/ui/widgets/progress_properti.dart';

class MonitoringPropertiPage extends StatelessWidget {
  const MonitoringPropertiPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daftar Proyek di Indoensia',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 16),
          SearchForm(),
        ],
      );
    }

    Widget listProgressProyek() {
      return Column(
        children: [
          ProgressProperti(29),
          ProgressProperti(100),
          ProgressProperti(0, isFail: true),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        children: [
          header(),
          SizedBox(height: 16),
          listProgressProyek(),
        ],
      ),
    );
  }
}
