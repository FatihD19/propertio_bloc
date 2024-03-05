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

class SimulasiKprPage extends StatefulWidget {
  const SimulasiKprPage({super.key});

  @override
  State<SimulasiKprPage> createState() => _SimulasiKprPageState();
}

class _SimulasiKprPageState extends State<SimulasiKprPage> {
  int _sliderVal = 1;
  final TextEditingController propertyPriceController = TextEditingController();
  final TextEditingController downPaymentController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController loanTermController = TextEditingController();
  double downPaymentPercen = 0;
  @override
  Widget build(BuildContext context) {
    Widget form() {
      return Column(
        children: [
          CustomTextField(
              title: 'Harga Properti',
              hintText: 'Harga Properti',
              mandatory: false,
              controller: propertyPriceController,
              prefix:
                  Text("Rp. ", style: primaryTextStyle.copyWith(fontSize: 16))),
          SizedBox(height: 8),
          CustomTextField(
            controller: interestRateController,
            title: 'Suku Bunga',
            hintText: 'Suku Bunga',
            mandatory: false,
            suffix: Text('%', style: primaryTextStyle.copyWith(fontSize: 18)),
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
                    final input = LoanSimulationInput(
                      propertyPrice: double.parse(
                          propertyPriceController.text.replaceAll('.', '')),
                      downPayment: double.parse(
                          downPaymentController.text.replaceAll('.', '')),
                      interestRate: double.parse(interestRateController.text),
                      loanTerm: int.parse(loanTermController.text),
                    );
                    context.read<KprCubit>().calculate(input);
                    print(propertyPriceController.text);
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

    Widget itemAngsuran(String angsuran, String waktu, {bool? isSelected}) {
      return Container(
        decoration: customBoxDecoration(),
        width: 176,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ringkasan :',
                style:
                    primaryTextStyle.copyWith(fontWeight: bold, fontSize: 12)),
            SizedBox(height: 8),
            Text(angsuran,
                style:
                    primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
            SizedBox(height: 8),
            Text('Jangka Waktu : ',
                style: primaryTextStyle.copyWith(fontSize: 12)),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 46, vertical: 4),
              decoration: BoxDecoration(
                color:
                    isSelected == true ? Color(0xff219653) : Color(0xff2D9CDB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(waktu + ' Tahun',
                  style:
                      buttonTextStyle.copyWith(fontWeight: bold, fontSize: 12)),
            )
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
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ringkasan(
                          '${_formatCurrency(state.installmentResults.summaryPrincipalLoan)}',
                          '${_formatCurrency(state.installmentResults.summaryInterestPrice)}',
                          '${_formatCurrency(state.installmentResults.summaryTotalLoan)}'),
                      for (var entry
                          in state.installmentResults.installmentByYear.entries)
                        // Text(
                        //     '${entry.key} years: ${_formatCurrency(entry.value)}'),
                        itemAngsuran(
                            _formatCurrency(entry.value), entry.key.toString(),
                            isSelected:
                                entry.key.toString() == loanTermController.text
                                    ? true
                                    : false),
                    ],
                  ),
                );
              } else if (state is KprError) {
                return Text(state.message);
              }
              return Container();
            },
          ),
          // Center(
          //   child: Wrap(
          //     spacing: 10,
          //     runSpacing: 10,
          //     children: [
          //       itemAngsuran('Rp 10.270.000', '14', isSelected: true),
          //       itemAngsuran('Rp 10.270.000', '14'),
          //       itemAngsuran('Rp 10.270.000', '14'),
          //       itemAngsuran('Rp 10.270.000', '14'),
          //       itemAngsuran('Rp 10.270.000', '14'),
          //       itemAngsuran('Rp 10.270.000', '14'),
          //     ],
          //   ),
          // ),
          SizedBox(height: 16),
          Text(
              '*Angka yang ditampilkan di atas adalah perkiraan, dan perhitungan aktual dapat berbeda dari yang diberikan oleh bank. Silakan hubungi kami untuk informasi lebih lanjut. ',
              style: primaryTextStyle.copyWith(fontSize: 12)),
        ],
      );
    }

    Widget itemFaq() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.only(bottom: 8),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text('Apa yang dimaksud dengan KPR?',
                style: primaryTextStyle.copyWith(fontSize: 14)),
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, bottom: 16),
                child: Column(
                  children: [
                    Text(
                        'Secara umum, ada dua jenis suku bunga KPR yang diberlakukan bank, yaitu: Fixed rate, Floating rate. Suku bunga tetap dikenakan kepada debitur menggunakan patokan angka tertentu selama tenor yang telah ditentukan. Besar bunga yang ditetapkan kepada debitur mengikuti fluktuasi suku bunga acuan (BI rate).',
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
          itemFaq(),
          itemFaq(),
          itemFaq(),
          itemFaq(),
        ],
      );
    }

    return Scaffold(
        appBar: propertioAppBar(),
        drawer: SideBar(),
        body: Container(
          color: bgColor1,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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

String _formatCurrency(double amount) {
  String formattedString = amount.toStringAsFixed(0);
  return formattedString.currencyFormatRp;
}
