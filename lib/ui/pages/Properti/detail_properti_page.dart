// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/properti/properti_bloc.dart';
import 'package:propertio_mobile/data/model/properti_model.dart';
import 'package:propertio_mobile/data/model/responses/detail_properti_response_model.dart';
import 'package:propertio_mobile/shared/api_path.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/shared/utils.dart';
import 'package:propertio_mobile/ui/component/bottom_modal.dart';
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
import 'package:propertio_mobile/ui/view/listile_agen.dart';
import 'package:propertio_mobile/ui/view/send_message_view.dart';
import 'package:propertio_mobile/ui/view/video_view.dart';

class DetailPropertiPage extends StatelessWidget {
  final String slug;
  DetailPropertiPage(this.slug, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertiBloc()..add(OnGetDetailProperti(slug)),
      child: BlocBuilder<PropertiBloc, PropertiState>(
        builder: (context, state) {
          if (state is PropertiLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is PropertiError) {
            return Scaffold(body: TextFailure(message: state.message));
          }
          if (state is PropertiDetailLoaded) {
            DetailPropertiModel detailProperti = state.propertiModel.data!;
            // String urlVideo = detailProperti.propertyVideo == null
            //     ? ''
            //     : detailProperti.propertyVideo!.link!.substring(
            //         detailProperti.propertyVideo!.link!.length - 11,
            //         detailProperti.propertyVideo!.link!.length);
            double pricePerArea = detailProperti.propertyDetail!.surfaceArea ==
                        '0' ||
                    detailProperti.propertyDetail!.price == '0'
                ? 0
                : double.parse(detailProperti.propertyDetail!.price!) /
                    double.parse(detailProperti.propertyDetail!.surfaceArea!);
            bool isRent = detailProperti.listingType == 'rent';
            return Scaffold(
              body: Container(
                color: bgColor1,
                child: ListView(children: [
                  InfoPromoCarousel(
                      detailProperti.propertyPhoto!
                          .map((propertiPhoto) => propertiPhoto.filename)
                          .toList(),
                      isVirtual: true,
                      virtualUrl: detailProperti.propertyVirtualTour?.link),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Column(
                      children: [
                        HeadlinePropertiView(
                          status: detailProperti.listingType,
                          title: detailProperti.title,
                          rangePrice:
                              detailProperti.propertyDetail!.price.toString(),
                          headline: detailProperti.headline,
                          address: Address(
                            address: detailProperti.address,
                            city: detailProperti.city,
                            district: detailProperti.district,
                            province: detailProperti.province,
                            postalCode: detailProperti.postalCode,
                            latitude: detailProperti.latitude,
                            longitude: detailProperti.longitude,
                          ),
                          countViews: detailProperti.views,
                          shareUrl: ShareUrl.properti(slug),
                          postedAt: detailProperti.postedAt,
                        ),
                        SizedBox(height: 16),
                        DetailOverView(
                          status: detailProperti.listingType,
                          propertiType: detailProperti.propertyType!.name,
                          certificate: detailProperti.certificate,
                          surfaceArea:
                              detailProperti.propertyDetail!.surfaceArea,
                          buildingArea:
                              detailProperti.propertyDetail!.buildingArea,
                          bedRoom: detailProperti.propertyDetail!.bedroom,
                          bathRoom: detailProperti.propertyDetail!.bathroom,
                          garage: detailProperti.propertyDetail!.garage,
                        ),
                        SizedBox(height: 16),
                        DescriptionView(
                            description: detailProperti.description.toString()),
                        SizedBox(height: 16),
                        DetailInfoView(listInfo: [
                          RowTextInfo(
                              title: 'Kode Unit',
                              value: detailProperti.propertyCode.toString()),
                          RowTextInfo(
                              title: 'Harga',
                              value: detailProperti.propertyDetail!.price
                                  .toString()),
                          RowTextInfo(
                              title: 'Jumlah Lantai',
                              value: detailProperti.propertyDetail!.floor
                                  .toString()),
                          RowTextInfo(
                              title: 'Kamar Mandi',
                              value: detailProperti.propertyDetail!.bathroom
                                  .toString()),
                          RowTextInfo(
                              title: 'Daya Listrik',
                              value: detailProperti.propertyDetail!.powerSupply
                                  .toString()),
                          RowTextInfo(
                              title: 'Tipe Properti',
                              value:
                                  detailProperti.propertyType!.name.toString()),
                          detailProperti.listingType == 'rent'
                              ? SizedBox()
                              : RowTextInfo(
                                  title: 'Sertifikat',
                                  value: detailProperti.certificate.toString()),
                          RowTextInfo(
                              title: 'Luas Tanah',
                              value:
                                  '${detailProperti.propertyDetail?.surfaceArea} m2'),
                          RowTextInfo(
                              title: 'Luas Bangunan',
                              value:
                                  '${detailProperti.propertyDetail?.buildingArea} m2'),
                          RowTextInfo(
                              title: 'Kamar',
                              value: detailProperti.propertyDetail!.bedroom
                                  .toString()),
                          RowTextInfo(
                              title: 'Tempat Parkir',
                              value: detailProperti.propertyDetail!.garage
                                  .toString()),
                          RowTextInfo(
                              title: 'Jenis Air',
                              value: detailProperti.propertyDetail!.waterType
                                  .toString()),
                          RowTextInfo(
                              title: 'Kondisi',
                              value: detailProperti.propertyDetail!.condition
                                  .toString()),
                          RowTextInfo(
                              title: 'Akses Jalan',
                              value:
                                  '${detailProperti.propertyDetail!.roadAccess}'),
                          RowTextInfo(
                              title: 'Menghadap',
                              value:
                                  '${detailProperti.propertyDetail!.facing}'),
                          RowTextInfo(
                              title: 'Interior',
                              value: detailProperti.propertyDetail!.interior
                                  .toString()),
                        ]),
                        SizedBox(height: 16),
                        AlamatInfoView([
                          RowTextInfo(
                              title: 'Alamat Lengkap',
                              value: detailProperti.address.toString()),
                          RowTextInfo(
                              title: 'Kode Pos',
                              value: detailProperti.postalCode.toString()),
                          RowTextInfo(
                              title: 'Kota/Kabupaten',
                              value: detailProperti.city.toString()),
                          RowTextInfo(
                              title: 'Kecamatan',
                              value: detailProperti.district.toString()),
                          RowTextInfo(
                              title: 'Provinsi',
                              value: detailProperti.province.toString()),
                        ]),
                        SizedBox(height: 16),
                        InfoMapView(
                            lantitude: detailProperti.latitude.toString(),
                            longitude: detailProperti.longitude.toString()),
                        SizedBox(height: 16),
                        PropertyFacilityView(detailProperti.propertyFacility!),
                        detailProperti.propertyVideo == null
                            ? Text('Tidak tersedia video')
                            : SizedBox(),
                        WebviewtubeDemo(
                            '${detailProperti.propertyVideo?.link}'),
                        SizedBox(height: 16),
                        ListileAgent(
                            agent: detailProperti.agent,
                            onTap: () {
                              showCustomSnackbar(
                                  context,
                                  ModalInformasi(
                                    agent: detailProperti.agent,
                                    propertyCode: detailProperti.propertyCode,
                                  ),
                                  type: 'info');
                            })
                      ],
                    ),
                  )
                ]),
              ),
              bottomNavigationBar: ContactUsDetail(
                waMessasge: detailProperti.title,
                waNumber: detailProperti.agent!.phone.toString(),
                price:
                    formatCurrency('${detailProperti.propertyDetail?.price}'),
                surfaceArea: formatCurrency(pricePerArea.toInt().toString()),
                isRent: isRent,
              ),
            );
          }
          return Scaffold(body: SizedBox());
        },
      ),
    );
  }
}
