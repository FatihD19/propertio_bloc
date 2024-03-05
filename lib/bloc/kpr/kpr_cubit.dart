import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/model/request/kpr_simulation_model.dart';

part 'kpr_state.dart';

class KprCubit extends Cubit<KprState> {
  KprCubit() : super(KprInitial());
  void calculate(LoanSimulationInput input) {
    // final monthlyInstallment = ((input.propertyPrice - input.downPayment) *
    //         (input.interestRate / 100) *
    //         input.loanTerm) /
    //     (input.loanTerm * 12);
    final installmentByYear = <int, double>{};

    for (int year in [input.loanTerm, 5, 10, 15, 20, 25, 30]) {
      final interestPrice = ((input.propertyPrice - input.downPayment));
      final interestRate = (input.interestRate / 100) * input.loanTerm;
      final loanTerm = year * 12;

      final monthlyPayment = (interestPrice * interestRate) / loanTerm;
      // final monthlyInterestRate = input.interestRate / 100 / 12;
      // final totalMonths = year * 12;
      // final powValue = pow(1 + monthlyInterestRate, totalMonths);
      // final monthlyPayment = ((input.propertyPrice - input.downPayment) *
      //         monthlyInterestRate *
      //         powValue) /
      //     (powValue - 1);
      installmentByYear[year] = monthlyPayment;
    }

    emit(KprLoaded(LoanSimulationResult(
      // monthlyInstallment: monthlyInstallment,
      summaryPrincipalLoan: input.propertyPrice - input.downPayment,
      summaryInterestPrice: ((input.propertyPrice - input.downPayment) *
          (input.interestRate / 100)),
      summaryTotalLoan: (input.propertyPrice - input.downPayment) +
          ((input.propertyPrice - input.downPayment) *
              (input.interestRate / 100)),
      installmentByYear: installmentByYear,
    )));
  }
  // void dispose() {
  //   emit(KprInitial());
  // }

  void reset() {
    emit(KprInitial());
  }
}
