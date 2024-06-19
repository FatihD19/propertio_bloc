import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_bloc/bloc/homePage/home_page_bloc.dart';
import 'package:propertio_bloc/bloc/properti/properti_bloc.dart';
import 'package:propertio_bloc/shared/theme.dart';
import 'package:propertio_bloc/ui/component/search_form.dart';
import 'package:propertio_bloc/ui/component/text_failure.dart';
import 'package:propertio_bloc/ui/pages/Properti/properti_page.dart';
import 'package:propertio_bloc/ui/pages/Proyek/proyek_page.dart';
import 'package:propertio_bloc/ui/view/info_promo_view.dart';
import 'package:propertio_bloc/ui/widgets/agent_card.dart';
import 'package:propertio_bloc/ui/widgets/item_tipe_apartemen.dart';
import 'package:propertio_bloc/ui/widgets/properti_card.dart';
import 'package:propertio_bloc/ui/widgets/proyek_card.dart';
import 'package:propertio_bloc/ui/widgets/review_card.dart';
import 'package:propertio_bloc/ui/widgets/small_proyek_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final propertiSearch = TextEditingController();
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Image.asset('assets/img_banner_properti.jpeg')),
          SearchForm(
            action: () {
              context.read<PropertiBloc>().add(OnGetProperti(
                  query: propertiSearch.text,
                  isRent: false,
                  type: selectedType));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PropertiPage(fromHomePage: true, isRent: false)));
            },
            controller: propertiSearch,
            onChanged: (value) {
              setState(() {
                selectedType = value!;
              });
            },
            selectedItem: selectedType,
            sellOrRent: 0,
            fromHomePage: true,
          ),
        ],
      );
    }

    Widget recomendation() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rekomendasi',
                  style: primaryTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16)),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertiPage(isRent: false)));
                  },
                  child: Text('Lihat lebih banyak', style: thirdTextStyle))
            ],
          ),
          SizedBox(height: 8),
          BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state is HomePageLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomePageError) {
                return TextFailure(message: state.message);
              }
              if (state is HomePageLoaded) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: state.homePageModel.data!.propertyRecomendation!
                          .map((properti) =>
                              PropertiCard(properti, marginRight: true))
                          .toList()),
                );
              }
              return SizedBox();
            },
          ),
        ],
      );
    }

    Widget proyekTerbaik() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pilihan Proyek Terbaik',
                  style: primaryTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16)),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProyekPage()));
                  },
                  child: Text('Lihat lebih banyak', style: thirdTextStyle))
            ],
          ),
          SizedBox(height: 8),
          BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state is HomePageLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomePageError) {
                return TextFailure(message: state.message);
              }
              if (state is HomePageLoaded) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: state.homePageModel.data!.projectRecomendation!
                          .map((proyek) => SmallProyekCard(proyek: proyek))
                          .toList()),
                );
              }
              return SizedBox();
            },
          ),
        ],
      );
    }

    Widget proyekTerbaru() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Proyek Terbaru',
                  style: primaryTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16)),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProyekPage()));
                  },
                  child: Text('Lihat lebih banyak', style: thirdTextStyle))
            ],
          ),
          SizedBox(height: 8),
          BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state is HomePageLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomePageError) {
                return TextFailure(message: state.message);
              }
              if (state is HomePageLoaded) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: state.homePageModel.data!.projectRecomendation!
                          .map((proyek) => ProyekCard(proyek))
                          .toList()),
                );
              }
              return SizedBox();
            },
          ),
        ],
      );
    }

    Widget agen() {
      return Column(
        children: [
          Text('Agen Pilihan',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 8),
          BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state is HomePageLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomePageError) {
                return TextFailure(message: state.message);
              }
              if (state is HomePageLoaded) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: state.homePageModel.data!.agents!
                          .map((agent) => AgentCard(agent, useMargin: true))
                          .toList()),
                );
              }
              return SizedBox();
            },
          ),
        ],
      );
    }

    Widget testimoni() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Testimoni',
                  style: primaryTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16)),
              Text('Lihat lebih banyak', style: thirdTextStyle)
            ],
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ReviewCard(),
                ReviewCard(),
                ReviewCard(),
              ],
            ),
          ),
        ],
      );
    }

    Widget tipeApartemen() {
      return Column(
        children: [
          Text('Eksplor berbagai tipe Properti',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ItemTipeApartemen('Surabaya',
                    img: 'assets/img_tp_apart_surabaya.png'),
                ItemTipeApartemen('Yogyakarta',
                    img: 'assets/img_tp_apart_yogya.png'),
                ItemTipeApartemen('Semarang',
                    img: 'assets/img_tp_apart_semarang.png'),
                ItemTipeApartemen('Jakarta',
                    img: 'assets/img_tp_apart_jakarta.png'),
              ],
            ),
          ),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      color: bgColor1,
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<HomePageBloc>().add(OnGetHomePage());
        },
        child: ListView(
          shrinkWrap: true,
          children: [
            header(),
            SizedBox(height: 16),
            recomendation(),
            SizedBox(height: 16),
            proyekTerbaik(),
            SizedBox(height: 16),
            proyekTerbaru(),
            SizedBox(height: 16),
            // InfoPromoCarousel([
            //   'assets/img_info_promo.png',
            //   'assets/img_info_promo.png',
            // ]),
            tipeApartemen(),
            SizedBox(height: 16),
            agen(),
            SizedBox(height: 16),
            // testimoni(),
            // SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
