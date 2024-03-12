import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masked_text_field/masked_text_field.dart';
import 'package:propertio_mobile/bloc/kpr/kpr_cubit.dart';
import 'package:propertio_mobile/data/model/request/kpr_simulation_model.dart';
import 'dart:math';

import 'package:propertio_mobile/shared/utils.dart';

class MortgageCalculator extends StatefulWidget {
  @override
  _MortgageCalculatorState createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {
  final TextEditingController propertyPriceController = TextEditingController();
  final TextEditingController downPaymentController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController loanTermController = TextEditingController();

  String monthlyInstallment = '';
  Map<int, String> installmentResults = {};
  @override
  void initState() {
    context.read<KprCubit>().reset();
    super.initState();
  }
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: MortgageSimulationForm(),
      // body: Padding(
      //   padding: EdgeInsets.all(16.0),
      //   child: ListView(
      //     children: [
      //       MortgageSimulationForm(),
      //       TextFormField(
      //         controller: propertyPriceController,
      //         keyboardType: TextInputType.number,
      //         decoration: InputDecoration(labelText: 'Harga Properti (Rp)'),
      //       ),
      //       TextFormField(
      //         controller: downPaymentController,
      //         keyboardType: TextInputType.number,
      //         decoration: InputDecoration(labelText: 'Uang Muka (Rp)'),
      //       ),
      //       TextFormField(
      //         controller: interestRateController,
      //         keyboardType: TextInputType.number,
      //         decoration: InputDecoration(labelText: 'Bunga (%)'),
      //       ),
      //       TextFormField(
      //         controller: loanTermController,
      //         keyboardType: TextInputType.number,
      //         decoration: InputDecoration(labelText: 'Jangka Waktu (tahun)'),
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () {
      //           calculateMonthlyInstallment();
      //         },
      //         child: Text('Hitung Angsuran Bulanan'),
      //       ),
      //       SizedBox(height: 20),
      //       Text(
      //         'Angsuran per Bulan (${loanTermController.text} tahun): $monthlyInstallment',
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //       ),
      //       SizedBox(height: 20),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             'Angsuran per Bulan dalam 5, 10, 15, 20, dan 30 tahun:',
      //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //           ),
      //           SizedBox(height: 10),
      //           for (var entry in installmentResults.entries)
      //             Text(
      //               '${entry.key} tahun: ${entry.value}',
      //               style: TextStyle(fontSize: 16),
      //             ),
      //         ],
      //       ),
      //       SizedBox(height: 20),
      //     ],
      //   ),
      // ),
    );
  }

  String calculateMonthlyInstallment1(String jangkaWaktu) {
    double propertyPrice = double.parse(propertyPriceController.text);
    double downPayment = double.parse(downPaymentController.text);
    double interestRate = double.parse(interestRateController.text);
    int loanTerm = int.parse(jangkaWaktu);

    double loanAmount = propertyPrice - downPayment;
    double monthlyInterestRate = (interestRate / 100) / 12;
    int loanMonths = loanTerm * 12;

    double monthlyPayment = (loanAmount *
            monthlyInterestRate *
            (pow(1 + monthlyInterestRate, loanMonths))) /
        (pow(1 + monthlyInterestRate, loanMonths) - 1);
    return _formatCurrency(monthlyPayment);
  }

  void calculateMonthlyInstallment() {
    setState(() {
      monthlyInstallment =
          calculateMonthlyInstallment1(loanTermController.text);

      installmentResults.clear();
      installmentResults[5] = calculateMonthlyInstallment1('5');
      installmentResults[10] = calculateMonthlyInstallment1('10');
      installmentResults[15] = calculateMonthlyInstallment1('15');
      installmentResults[20] = calculateMonthlyInstallment1('20');
      installmentResults[30] = calculateMonthlyInstallment1('30');
    });
  }
}

String _formatCurrency(double amount) {
  String formattedString = amount.toStringAsFixed(0);
  return formattedString.currencyFormatRp;
}

class MortgageSimulationForm extends StatelessWidget {
  final MortgageSimulationCubit cubit = MortgageSimulationCubit();
  final TextEditingController propertyPriceController =
      TextEditingController(text: '500000000');
  final TextEditingController downPaymentController =
      TextEditingController(text: '100000000');
  final TextEditingController interestRateController =
      TextEditingController(text: '7');
  final TextEditingController loanTermController =
      TextEditingController(text: '14');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => cubit,
        child: Scaffold(
          appBar: AppBar(title: Text('Mortgage Simulation')),
          body: BlocProvider(
              create: (context) => MortgageSimulationCubit(),
              child:
                  BlocBuilder<MortgageSimulationCubit, MortgageSimulationState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        TextField(
                          controller: propertyPriceController,
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Harga Properti (Rp)'),
                        ),
                        TextField(
                          controller: downPaymentController,
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Uang Muka (Rp)'),
                        ),
                        TextField(
                          controller: interestRateController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Bunga (%)'),
                        ),
                        TextField(
                          controller: loanTermController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Jangka Waktu (Tahun)'),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            double propertyPrice =
                                double.parse(propertyPriceController.text);
                            double downPayment =
                                double.parse(downPaymentController.text);
                            double interestRate =
                                double.parse(interestRateController.text);
                            int loanTerm = int.parse(loanTermController.text);

                            MortgageSimulationRequest request =
                                MortgageSimulationRequest(
                              propertyPrice: propertyPrice,
                              downPayment: downPayment,
                              interestRate: interestRate,
                              loanTerm: loanTerm,
                            );

                            BlocProvider.of<MortgageSimulationCubit>(context)
                                .calculateMortgage(request);
                          },
                          child: Text('Hitung'),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Hasil Simulasi:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        if (state is MortgageSimulationLoaded)
                          for (int i = 0;
                              i < state.result.monthlyInstallments.length;
                              i++)
                            Text(
                              'Angsuran per Bulan (${i + 1} tahun): ${_formatCurrency(state.result.monthlyInstallments[i])}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                        // Column(
                        //   children: state.result.monthlyInstallments
                        //       .map((e) => Text(
                        //           'Angsuran per Bulan ( tahun): ${_formatCurrency(e)}',
                        //           style: TextStyle(
                        //               fontSize: 18,
                        //               fontWeight: FontWeight.bold)))
                        //       .toList(),
                        // ),
                      ],
                    ),
                  );
                },
              )),
        ));
  }
}
