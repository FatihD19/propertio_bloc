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
      appBar: AppBar(
        title: Text('Simulasi Kredit Rumah'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            LoanSimulationForm(),
            TextFormField(
              controller: propertyPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harga Properti (Rp)'),
            ),
            TextFormField(
              controller: downPaymentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Uang Muka (Rp)'),
            ),
            TextFormField(
              controller: interestRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Bunga (%)'),
            ),
            TextFormField(
              controller: loanTermController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jangka Waktu (tahun)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateMonthlyInstallment();
              },
              child: Text('Hitung Angsuran Bulanan'),
            ),
            SizedBox(height: 20),
            Text(
              'Angsuran per Bulan (${loanTermController.text} tahun): $monthlyInstallment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Angsuran per Bulan dalam 5, 10, 15, 20, dan 30 tahun:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                for (var entry in installmentResults.entries)
                  Text(
                    '${entry.key} tahun: ${entry.value}',
                    style: TextStyle(fontSize: 16),
                  ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
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

class LoanSimulationForm extends StatefulWidget {
  @override
  State<LoanSimulationForm> createState() => _LoanSimulationFormState();
}

class _LoanSimulationFormState extends State<LoanSimulationForm> {
  final TextEditingController propertyPriceController = TextEditingController();

  final TextEditingController downPaymentController =
      TextEditingController(text: '100000000');

  final TextEditingController interestRateController =
      TextEditingController(text: '7');

  final TextEditingController loanTermController =
      TextEditingController(text: '8');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: propertyPriceController,
            decoration: InputDecoration(labelText: 'Property Price'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: propertyPriceController,
            onChanged: (value) {
              propertyPriceController.value = TextEditingValue(
                text: value.replaceAll(',', '.'),
                selection: TextSelection.collapsed(offset: value.length),
              );
            },
            decoration: InputDecoration(
                labelText: 'Property Price', prefix: Text('Rp ')),
            inputFormatters: <TextInputFormatter>[
              CurrencyTextInputFormatter(
                decimalDigits: 0,
                symbol: '',
              ),
            ],
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: downPaymentController,
            decoration: InputDecoration(labelText: 'Down Payment'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: interestRateController,
            decoration: InputDecoration(labelText: 'Interest Rate (%)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: loanTermController,
            decoration: InputDecoration(labelText: 'Loan Term (years)'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final input = LoanSimulationInput(
                propertyPrice: double.parse(
                    propertyPriceController.text.replaceAll('.', '')),
                downPayment: double.parse(downPaymentController.text),
                interestRate: double.parse(interestRateController.text),
                loanTerm: int.parse(loanTermController.text),
              );
              context.read<KprCubit>().calculate(input);
              print(propertyPriceController.text);
            },
            child: Text('Calculate'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<KprCubit>().reset();
            },
            child: Text('reset'),
          ),
          SizedBox(height: 16),
          BlocBuilder<KprCubit, KprState>(
            builder: (context, state) {
              if (state is KprLoading) {
                return CircularProgressIndicator();
              } else if (state is KprLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var entry
                        in state.installmentResults.installmentByYear.entries)
                      Text(
                          '${entry.key} years: ${_formatCurrency(entry.value)}'),
                  ],
                );
              } else if (state is KprError) {
                return Text(state.message);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
