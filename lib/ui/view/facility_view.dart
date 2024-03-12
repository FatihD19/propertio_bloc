import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propertio_mobile/data/model/responses/detail_project_response_model.dart';
import 'package:propertio_mobile/data/model/responses/detail_properti_response_model.dart';
import 'package:propertio_mobile/shared/api_path.dart';
import 'package:propertio_mobile/shared/theme.dart';

class FacilityView extends StatelessWidget {
  final List<ProjectFacility> facility;

  FacilityView(this.facility, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget itemFacility(String icUrl, String title) {
      return Container(
        width: 170,
        child: Row(
          children: [
            SvgPicture.network(
              ApiPath.image(
                icUrl,
              ),
              width: 25,
              height: 25,
            ),
            SizedBox(width: 5),
            Text(title, style: primaryTextStyle.copyWith(fontSize: 12)),
          ],
        ),
      );
    }

    Widget listFacility() {
      return Wrap(
        spacing: 15,
        runSpacing: 16,
        children: facility
            .map((fasilitas) => itemFacility(
                fasilitas.icon.toString(), fasilitas.name.toString()))
            .toList(),
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fasilitas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          listFacility(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class PropertyFacilityView extends StatelessWidget {
  final List<PropertyFacility> propertiFacility;

  PropertyFacilityView(this.propertiFacility, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget itemFacility(String icUrl, String title) {
      return Container(
        width: 170,
        child: Row(
          children: [
            SvgPicture.network(
              ApiPath.image(
                icUrl,
              ),
              width: 25,
              height: 25,
            ),
            SizedBox(width: 5),
            Text(title, style: primaryTextStyle.copyWith(fontSize: 12)),
          ],
        ),
      );
    }

    Widget listFacility() {
      return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 10,
            childAspectRatio: 6),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: propertiFacility
            .map((fasilitas) => itemFacility(
                fasilitas.icon.toString(), fasilitas.name.toString()))
            .toList(),
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fasilitas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          listFacility(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
