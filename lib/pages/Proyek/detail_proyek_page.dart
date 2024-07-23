// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_bloc/bloc/project/project_bloc.dart';
import 'package:propertio_bloc/data/model/responses/detail_project_response_model.dart';
import 'package:propertio_bloc/data/model/unit_model.dart';
import 'package:propertio_bloc/injection.dart';
import 'package:propertio_bloc/constants/api_path.dart';
import 'package:propertio_bloc/constants/theme.dart';
import 'package:propertio_bloc/shared/ui/components/button.dart';
import 'package:propertio_bloc/shared/ui/components/text_failure.dart';
import 'package:propertio_bloc/shared/ui/views/detail_info_view.dart';
import 'package:propertio_bloc/shared/ui/views/detail_overview_view.dart';
import 'package:propertio_bloc/shared/ui/views/info_map_view.dart';
import 'package:propertio_bloc/shared/ui/views/listile_agen.dart';
import 'package:propertio_bloc/shared/ui/views/promo_Ar_app.dart';
import 'package:propertio_bloc/shared/ui/views/video_view.dart';
import 'package:propertio_bloc/shared/ui/views/alamat_info_view.dart';
import 'package:propertio_bloc/shared/ui/views/contact_us_detail.dart';
import 'package:propertio_bloc/shared/ui/views/description_info_view.dart';

import 'package:propertio_bloc/shared/ui/views/headline_properti_view.dart';

import 'package:propertio_bloc/shared/ui/views/info_promo_view.dart';

import 'package:propertio_bloc/shared/ui/widgets/small_proyek_card.dart';
import 'package:propertio_bloc/shared/utils.dart';

import 'package:url_launcher/url_launcher.dart';

class DetailProyekPage extends StatelessWidget {
  final String slug;
  DetailProyekPage(this.slug, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget listUnit(
        List<UnitModel> listUnit, String projectCode, bool isFavorite) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Daftar Unit',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: listUnit
                  .map((unit) => SmallProyekCardUnit(
                        unit: unit,
                        isFavorite: isFavorite,
                        projectCode: projectCode,
                      ))
                  .toList(),
            ),
          ),
        ],
      );
    }

    return BlocProvider(
      create: (context) =>
          locator<ProjectBloc>()..add(OnGetDetailProject(slug)),
      child: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is ProjectError) {
            return Scaffold(body: TextFailure(message: state.message));
          }
          if (state is ProjectDetailLoaded) {
            var cheapestUnit = state.projectModel.data!.units!.data!.isEmpty
                ? UnitModel(price: '0')
                : state.projectModel.data!.units!.data!.reduce((curr, next) =>
                    int.parse(curr.price ?? '0') < int.parse(next.price ?? '0')
                        ? curr
                        : next);

            var mostExpensiveUnit = state
                    .projectModel.data!.units!.data!.isEmpty
                ? UnitModel(price: '0')
                : state.projectModel.data!.units!.data!.reduce((curr, next) =>
                    int.parse(curr.price ?? '0') > int.parse(next.price ?? '0')
                        ? curr
                        : next);
            DetailProjectModel proyek = state.projectModel.data!;
            String urlVideo = proyek.projectVideo == null
                ? ''
                : proyek.projectVideo!.link!.substring(
                    proyek.projectVideo!.link!.length - 11,
                    proyek.projectVideo!.link!.length);
            return Scaffold(
              body: Container(
                color: bgColor1,
                child: ListView(children: [
                  InfoPromoCarousel(
                      state.projectModel.data!.projectPhotos!
                          .map((projectPhoto) =>
                              projectPhoto.filename.toString())
                          .toList(),
                      isVirtual:
                          proyek.projectVirtualTour == null ? false : true,
                      virtualUrl: '${proyek.projectVirtualTour?.link}'),
                  // Text('${cheapestUnit.price} - ${mostExpensiveUnit.price}'),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Column(
                      children: [
                        HeadlinePropertiView(
                          isProyek: true,
                          rangePrice: cheapestUnit.price ==
                                  mostExpensiveUnit.price
                              ? '${formatCurrency(cheapestUnit.price ?? '0')}'
                              : '${formatCurrency(cheapestUnit.price ?? '0')} - ${formatCurrency(mostExpensiveUnit.price ?? '0')}',
                          title: proyek.title.toString(),
                          headline: proyek.headline.toString(),
                          address: proyek.address,
                          countViews: proyek.countViews,
                          shareUrl: ShareUrl.project(slug),
                          postedAt: proyek.postedAt,
                          isFavorite: proyek.isFavorites,
                          projectCode: proyek.projectCode,
                        ),
                        SizedBox(height: 16),
                        DetailOverView(
                            isProyek: true,
                            propertiType: proyek.propertyType?.name.toString(),
                            unitType: proyek.unitType.toString(),
                            certificate: proyek.certificate.toString(),
                            unitStock: proyek.unitStock.toString(),
                            buildYear: proyek.completedAt.toString()),
                        SizedBox(height: 16),
                        DescriptionView(
                            description: proyek.description.toString()),
                        SizedBox(height: 16),
                        DetailInfoView(listInfo: [
                          RowTextInfo(
                              title: 'Proyek Kode',
                              value: proyek.projectCode.toString()),
                          RowTextInfo(
                              title: 'Proyek Dibangun',
                              value: proyek.completedAt.toString()),
                          RowTextInfo(
                              title: 'Tipe Unit',
                              value: proyek.unitType.toString()),
                          RowTextInfo(
                              title: 'Tipe Properti',
                              value: proyek.propertyType!.name.toString()),
                          RowTextInfo(
                              title: 'Sertifikat',
                              value: proyek.certificate.toString()),
                          RowTextInfo(
                              title: 'Unit Tersedia',
                              value: proyek.unitStock.toString()),
                        ]),
                        SizedBox(height: 16),
                        AlamatInfoView([
                          RowTextInfo(
                              title: 'Alamat Lengkap',
                              value: proyek.address!.address.toString()),
                          RowTextInfo(
                              title: 'Kode Pos',
                              value: proyek.address!.postalCode.toString()),
                          RowTextInfo(
                              title: 'Kota/Kabupaten',
                              value: proyek.address!.city.toString()),
                          RowTextInfo(
                              title: 'Kecamatan',
                              value: proyek.address!.district.toString()),
                          RowTextInfo(
                              title: 'Provinsi',
                              value: proyek.address!.province.toString()),
                        ]),
                        SizedBox(height: 16),
                        InfoMapView(
                            lantitude: proyek.address!.latitude.toString(),
                            longitude: proyek.address!.longitude.toString()),
                        SizedBox(height: 16),
                        listUnit(state.projectModel.data?.units?.data ?? [],
                            '${proyek.projectCode}', proyek.isFavorites!),
                        SizedBox(height: 16),
                        InfoMapView(
                          isDenah: true,
                          urlImg: proyek.siteplanImage,
                        ),
                        SizedBox(height: 16),
                        CustomButton(
                            text: 'Unduh Brosur',
                            icon: Icons.menu_book_rounded,
                            onPressed: () {
                              launchUrl(Uri.parse(ApiPath.image(proyek
                                  .projectDocuments!.first.filename
                                  .toString())));
                            }),
                        SizedBox(height: 16),
                        PromoArApp(),
                        SizedBox(height: 16),
                        proyek.projectVideo == null
                            ? SizedBox()
                            : WebviewtubeDemo(urlVideo),
                        SizedBox(height: 16),
                        ListileDeveloper(
                            developer: proyek.developer, onTap: () {})
                      ],
                    ),
                  ),
                ]),
              ),
              bottomNavigationBar: ContactUsDetail(
                  waMessasge: proyek.title,
                  waNumber: proyek.developer?.phone.toString(),
                  isProyek: true,
                  price: cheapestUnit.price == mostExpensiveUnit.price
                      ? '${formatCurrency(cheapestUnit.price ?? '0')}'
                      : '${formatCurrency(cheapestUnit.price ?? '0')} - ${formatCurrency(mostExpensiveUnit.price ?? '0')}'),
            );
          }
          return Scaffold(body: SizedBox());
        },
      ),
    );
  }
}
