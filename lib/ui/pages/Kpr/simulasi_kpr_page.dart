// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/kpr/kpr_cubit.dart';
import 'package:propertio_mobile/data/model/request/kpr_simulation_model.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/shared/utils.dart';
import 'package:propertio_mobile/ui/component/button.dart';
import 'package:propertio_mobile/ui/component/container_style.dart';
import 'package:propertio_mobile/ui/component/sidebar.dart';
import 'package:propertio_mobile/ui/component/textfieldForm.dart';
import 'package:propertio_mobile/ui/view/detail_info_view.dart';
import 'package:propertio_mobile/ui/widgets/item_angsuran.dart';

class SimulasiKprPage extends StatefulWidget {
  const SimulasiKprPage({super.key});

  @override
  State<SimulasiKprPage> createState() => _SimulasiKprPageState();
}

class _SimulasiKprPageState extends State<SimulasiKprPage> {
  int _sliderVal = 1;
  TextEditingController propertyPriceController = TextEditingController();
  TextEditingController downPaymentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController loanTermController = TextEditingController();
  double downPaymentPercen = 0;
  @override
  Widget build(BuildContext context) {
    Widget form() {
      return Column(
        children: [
          CustomTextField(
              isNumber: true,
              title: 'Harga Properti',
              hintText: 'Harga Properti',
              mandatory: false,
              controller: propertyPriceController,
              prefix:
                  Text("Rp. ", style: primaryTextStyle.copyWith(fontSize: 16))),
          SizedBox(height: 8),
          IgnorePointer(
            ignoring: true,
            child: CustomTextField(
              isNumber: true,
              controller: interestRateController,
              title: 'Suku Bunga',
              hintText: 'Suku Bunga',
              mandatory: false,
              suffix: Text('%', style: primaryTextStyle.copyWith(fontSize: 18)),
            ),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Slider(
                min: 1,
                max: 15,
                divisions: 15,
                label: '${_sliderVal}%',
                thumbColor: Colors.white,
                value: _sliderVal.toDouble(),
                onChanged: (newValue) {
                  setState(() {
                    _sliderVal = newValue.round();
                    interestRateController.text = _sliderVal.toString();
                  });
                },
                // 14
                activeColor: primaryColor,
                inactiveColor: secondaryColor,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('1%', style: primaryTextStyle.copyWith(fontSize: 12)),
                    Spacer(),
                    Text('15%', style: primaryTextStyle.copyWith(fontSize: 12)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Uang Muka',
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 75,
                    child: CustomTextField(
                      isNumber: true,
                      controller: TextEditingController(
                          text: '${downPaymentPercen.toInt()}'),
                      suffix: Text('%',
                          style: primaryTextStyle.copyWith(fontSize: 18)),
                      hintText: 'Persen',
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                      child: CustomTextField(
                    isNumber: true,
                    prefix: Text("Rp. ",
                        style: primaryTextStyle.copyWith(fontSize: 16)),
                    hintText: 'Rp.100.000.000',
                    controller: downPaymentController,
                    onChanged: (value) {
                      setState(() {
                        downPaymentPercen = value.isEmpty
                            ? 0
                            : (double.parse(value.replaceAll(',', '')) /
                                    double.parse(propertyPriceController.text
                                        .replaceAll('.', ''))) *
                                100;
                      });
                    },
                  )),
                ],
              ),
              SizedBox(height: 8),
              CustomTextField(
                isNumber: true,
                suffix: Text('Tahun',
                    style: primaryTextStyle.copyWith(fontSize: 16)),
                controller: loanTermController,
                title: 'Jangka Waktu',
                hintText: 'Jangka Waktu',
                mandatory: false,
              ),
              SizedBox(height: 8),
              CustomButton(
                  text: 'Mulai Simulasikan',
                  onPressed: () {
                    context.read<KprCubit>().calculate(LoanSimulationInput(
                          propertyPrice: double.parse(
                              propertyPriceController.text.replaceAll('.', '')),
                          downPayment: double.parse(
                              downPaymentController.text.replaceAll('.', '')),
                          interestRate:
                              double.parse(interestRateController.text),
                          loanTerm: int.parse(loanTermController.text),
                        ));
                    print(propertyPriceController.text);
                    print(loanTermController.text);
                  }),
              SizedBox(height: 8),
              CustomButton(
                  text: 'Reset',
                  onPressed: () {
                    setState(() {});
                    context.read<KprCubit>().reset();
                    propertyPriceController.clear();
                    downPaymentController.clear();
                    interestRateController.clear();
                    loanTermController.clear();
                    downPaymentPercen = 0;
                  }),
            ],
          ),
        ],
      );
    }

    Widget ringkasan(
      String pinjamanPokok,
      String bungaPinjaman,
      String totalPinjaman,
    ) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xffE6E6E6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ringkasan :',
                style:
                    primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pinjaman Pokok',
                    style: primaryTextStyle.copyWith(fontSize: 12)),
                Text(pinjamanPokok,
                    style: primaryTextStyle.copyWith(
                        fontSize: 12, fontWeight: bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bunga Pinjaman (${loanTermController.text} Tahun)',
                    style: primaryTextStyle.copyWith(fontSize: 12)),
                Text(bungaPinjaman,
                    style: primaryTextStyle.copyWith(
                        fontSize: 12, fontWeight: bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Pinjaman',
                    style: primaryTextStyle.copyWith(fontSize: 12)),
                Text(totalPinjaman,
                    style: primaryTextStyle.copyWith(
                        fontSize: 12, fontWeight: bold)),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      );
    }

    Widget listAngsuran() {
      return Column(
        children: [
          BlocBuilder<KprCubit, KprState>(
            builder: (context, state) {
              if (state is KprLoading) {
                return CircularProgressIndicator();
              } else if (state is KprLoaded) {
                return Center(
                  child: Column(
                    children: [
                      ringkasan(
                          formatCurrencyDouble(
                              state.installmentResults.summaryPrincipalLoan!),
                          formatCurrencyDouble(
                              state.installmentResults.summaryInterestPrice!),
                          formatCurrencyDouble(
                              state.installmentResults.summaryTotalLoan!)),
                      SizedBox(height: 12),
                      // GridView(
                      //     gridDelegate:
                      //         SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 2,
                      //             crossAxisSpacing: 10,
                      //             mainAxisSpacing: 10,
                      //             childAspectRatio: 1.3),
                      //     shrinkWrap: true,
                      //     physics: NeverScrollableScrollPhysics(),
                      //     children: state.installmentResults.installmentByYear!
                      //         .map((e) => ItemAngsuran(
                      //             formatCurrencyDouble(e.installment!),
                      //             e.year.toString(),
                      //             isSelected: loanTermController.text ==
                      //                     e.year.toString()
                      //                 ? true
                      //                 : false))
                      //         .toList())
                      Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: state.installmentResults.installmentByYear!
                              .map((e) => ItemAngsuran(
                                  formatCurrencyDouble(e.installment!),
                                  e.year.toString(),
                                  isSelected: loanTermController.text ==
                                          e.year.toString()
                                      ? true
                                      : false))
                              .toList())
                    ],
                  ),
                );
              } else if (state is KprError) {
                return Text(state.message);
              }
              return Container();
            },
          ),
          SizedBox(height: 16),
          Text(
              '*Angka yang ditampilkan di atas adalah perkiraan, dan perhitungan aktual dapat berbeda dari yang diberikan oleh bank. Silakan hubungi kami untuk informasi lebih lanjut. ',
              style: primaryTextStyle.copyWith(fontSize: 12)),
        ],
      );
    }

    Widget itemFaq(String title, String message) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.only(bottom: 8),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(title, style: primaryTextStyle.copyWith(fontSize: 14)),
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, bottom: 16),
                child: Column(
                  children: [
                    Text(message,
                        style: primaryTextStyle.copyWith(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget faqKpr() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pertanyaan Terkait KPR',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          SizedBox(height: 8),
          itemFaq('Apa yang dimaksud dengan KPR ?',
              'KPR adalah singkatan dari Kredit Pemilikan Rumah, yaitu suatu fasilitas kredit yang diberikan oleh perbankan kepada nasabah perorangan yang ingin membeli atau memperbaiki rumah. KPR memungkinkan nasabah untuk membayar rumah secara cicilan dalam jangka waktu dan bunga tertentu sesuai dengan perjanjian dengan bank. Ada dua jenis KPR yang tersedia di Indonesia, yaitu KPR subsidi dan KPR non-subsidi. KPR subsidi adalah kredit yang diperuntukkan bagi masyarakat berpenghasilan rendah dengan bunga yang lebih rendah dan syarat yang lebih mudah. KPR non-subsidi adalah kredit yang bisa digunakan oleh seluruh masyarakat dengan bunga dan syarat yang ditentukan oleh bank.'),
          itemFaq('Apa saja jenis suku bunga KPR?',
              'Secara umum, ada dua jenis suku bunga KPR yang diberlakukan bank, yaitu: Fixed rate, Floating rate. Suku bunga tetap dikenakan kepada debitur menggunakan patokan angka tertentu selama tenor yang telah ditentukan. Besar bunga yang ditetapkan kepada debitur mengikuti fluktuasi suku bunga acuan (BI rate).'),
        ],
      );
    }

    return Scaffold(
        appBar: propertioAppBar(),
        drawer: SideBar(),
        body: Container(
          color: bgColor1,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: ListView(
            children: [
              Image.asset('assets/img_kpr.png'),
              SizedBox(height: 16),
              form(),
              // SizedBox(height: 16),
              // ringkasan(),
              SizedBox(height: 16),
              listAngsuran(),
              SizedBox(height: 16),
              faqKpr(),
            ],
          ),
        ));
  }
}
