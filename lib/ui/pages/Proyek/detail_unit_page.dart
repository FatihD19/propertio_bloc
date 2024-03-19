// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertio_mobile/bloc/unit/unit_bloc.dart';
import 'package:propertio_mobile/data/model/responses/detail_unit_response_model.dart';
import 'package:propertio_mobile/shared/api_path.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/shared/utils.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/component/text_price.dart';
import 'package:propertio_mobile/ui/view/alamat_info_view.dart';
import 'package:propertio_mobile/ui/view/contact_us_detail.dart';
import 'package:propertio_mobile/ui/view/description_info_view.dart';
import 'package:propertio_mobile/ui/view/detail_info_view.dart';
import 'package:propertio_mobile/ui/view/detail_overview_view.dart';
import 'package:propertio_mobile/ui/view/facility_view.dart';
import 'package:propertio_mobile/ui/view/headline_properti_view.dart';
import 'package:propertio_mobile/ui/view/info_map_view.dart';
import 'package:propertio_mobile/ui/view/info_promo_view.dart';
import 'package:propertio_mobile/ui/view/infrastructure_view.dart';
import 'package:propertio_mobile/ui/view/listile_agen.dart';
import 'package:propertio_mobile/ui/view/video_view.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailUnitPage extends StatelessWidget {
  final String idUnit;
  DetailUnitPage(this.idUnit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UnitBloc()..add(OnGetDetailUnit(idUnit)),
      child: BlocBuilder<UnitBloc, UnitState>(
        builder: (context, state) {
          if (state is UnitLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is UnitError) {
            return Scaffold(body: TextFailure(message: state.message));
          }
          if (state is DetailUnitLoaded) {
            DetailUnitModel detailUnit = state.unitModel.data!;
            String urlVideo = detailUnit.unitVideo == null
                ? ''
                : detailUnit.unitVideo!.link!.substring(
                    detailUnit.unitVideo!.link!.length - 11,
                    detailUnit.unitVideo!.link!.length);
            double pricePerArea =
                detailUnit.surfaceArea == '0' || detailUnit.price == '0'
                    ? 0
                    : double.parse(detailUnit.price!) /
                        double.parse(detailUnit.surfaceArea!);
            return Scaffold(
              body: Container(
                color: bgColor1,
                child: ListView(
                  children: [
                    InfoPromoCarousel(
                      detailUnit.unitPhotos!
                          .map((unitPhoto) => unitPhoto.filename.toString())
                          .toList(),
                      isVirtual: true,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        children: [
                          HeadlinePropertiView(
                              title: detailUnit.title.toString(),
                              rangePrice: detailUnit.price.toString(),
                              headline: detailUnit.title.toString(),
                              address: detailUnit.address,
                              countViews: detailUnit.countViews,
                              postedAt: detailUnit.postedAt,
                              shareUrl: ShareUrl.unit(idUnit)),
                          SizedBox(height: 16),
                          DetailOverView(
                            propertiType:
                                detailUnit.propertyType!.name.toString(),
                            certificate: detailUnit.certificate,
                            surfaceArea: detailUnit.surfaceArea,
                            buildingArea: detailUnit.buildingArea,
                            bedRoom: detailUnit.bedroom,
                            bathRoom: detailUnit.bathroom,
                            garage: detailUnit.garage,
                          ),
                          SizedBox(height: 16),
                          DescriptionView(
                              description: detailUnit.description.toString()),
                          SizedBox(height: 16),
                          DetailInfoView(listInfo: [
                            RowTextInfo(
                                title: 'Kode Unit',
                                value: detailUnit.unitCode ?? '0'),
                            RowTextInfo(
                                title: 'Harga', value: detailUnit.price ?? '0'),
                            RowTextInfo(
                                title: 'Jumlah Lantai',
                                value: detailUnit.floor ?? '0'),
                            RowTextInfo(
                                title: 'Kamar Mandi',
                                value: detailUnit.bathroom ?? '0'),
                            RowTextInfo(
                                title: 'Daya Listrik',
                                value: detailUnit.powerSupply ?? ''),
                            RowTextInfo(
                                title: 'Teresdia',
                                value: detailUnit.stock ?? '0'),
                            RowTextInfo(
                                title: 'Tipe Properti',
                                value: detailUnit.propertyType!.name ?? '0'),
                            RowTextInfo(
                                title: 'Sertifikat',
                                value: detailUnit.certificate ?? '0'),
                            RowTextInfo(
                                title: 'Luas Bangunan',
                                value: detailUnit.buildingArea ?? '0'),
                            RowTextInfo(
                                title: 'Kamar',
                                value: detailUnit.bedroom ?? '0'),
                            RowTextInfo(
                                title: 'Tempat Parkir',
                                value: detailUnit.garage ?? '0'),
                            RowTextInfo(
                                title: 'Jenis Air',
                                value: detailUnit.waterType ?? ''),
                            RowTextInfo(
                                title: 'Interior',
                                value: detailUnit.interior ?? ''),
                          ]),
                          SizedBox(height: 16),
                          AlamatInfoView([
                            RowTextInfo(
                                title: 'Alamat Lengkap',
                                value: detailUnit.address!.address.toString()),
                            RowTextInfo(
                                title: 'Kode Pos',
                                value:
                                    detailUnit.address!.postalCode.toString()),
                            RowTextInfo(
                                title: 'Kota/Kabupaten',
                                value: detailUnit.address!.city.toString()),
                            RowTextInfo(
                                title: 'Kecamatan',
                                value: detailUnit.address!.district.toString()),
                            RowTextInfo(
                                title: 'Provinsi',
                                value: detailUnit.address!.province.toString()),
                          ]),
                          SizedBox(height: 16),
                          InfoMapView(
                              lantitude:
                                  detailUnit.address!.latitude.toString(),
                              longitude:
                                  detailUnit.address!.longitude.toString()),
                          SizedBox(height: 16),
                          FacilityView(detailUnit.projectFacilities!),
                          InfrastructureView(detailUnit.projectInfrastructure!),
                          // InfoMapView(isDenah: true,
                          // ),
                          // SizedBox(height: 16),
                          CustomButton(
                              text: '3D Model Unit',
                              icon: Icons.view_in_ar_outlined,
                              onPressed: () {}),
                          SizedBox(height: 16),
                          detailUnit.unitVideo == null
                              ? Text('Tidak tersedia video')
                              : WebviewtubeDemo(urlVideo),
                          SizedBox(height: 16),
                          detailUnit.unitDocuments!.isEmpty
                              ? Text('Tidak tersedia brosur')
                              : CustomButton(
                                  text: 'Unduh Brosur',
                                  icon: Icons.menu_book_rounded,
                                  onPressed: () {
                                    launchUrl(Uri.parse(ApiPath.image(detailUnit
                                        .unitDocuments!.first.filename
                                        .toString())));
                                  }),

                          SizedBox(height: 16),

                          ListileDeveloper(developer: detailUnit.developer)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: ContactUsDetail(
                  waMessasge: detailUnit.title,
                  waNumber: detailUnit.developer?.phone,
                  price: formatCurrency(detailUnit.price.toString()),
                  surfaceArea: formatCurrency(pricePerArea.toInt().toString()),
                  isUnit: true),
            );
          }
          return Scaffold(body: SizedBox());
        },
      ),
    );
  }
}
