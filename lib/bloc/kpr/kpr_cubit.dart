import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/model/request/kpr_simulation_model.dart';
import 'dart:math' as math;

part 'kpr_state.dart';

class MortgageSimulationCubit extends Cubit<MortgageSimulationState> {
  MortgageSimulationCubit() : super(MortgageSimulationInitial());

  void calculateMortgage(MortgageSimulationRequest request) {
    List<double> results = [];

    void kpr(int years) {
      double monthlyInterestRate = request.interestRate / 100 / 12;
      int numberOfPayments = years * 12;
      double loanAmount = request.propertyPrice - request.downPayment;

      // double monthlyPayment = (loanAmount * monthlyInterestRate) /
      //     (1 - (1 / (1 + monthlyInterestRate).math.pow(numberOfPayments)));
      double monthlyPayment = (loanAmount * monthlyInterestRate) /
          (1 - math.pow(1 + monthlyInterestRate, -numberOfPayments));
      results.add(monthlyPayment);
    }

    for (int years in [request.loanTerm, 5, 10, 15, 20, 25, 30]) {
      kpr(years);
    }

    // for (int years = years; years <= 30; years += 5) {
    //   results.add(monthlyPayment);
    // }
    // Simpan hasil simulasi dalam state
    emit(MortgageSimulationLoaded(
      MortgageSimulationResult(monthlyInstallments: results),
    ));
  }
}

class KprCubit extends Cubit<KprState> {
  KprCubit() : super(KprInitial());
  void calculate(LoanSimulationInput input) {
    double calculateKpr(int years) {
      double loanAmount = input.propertyPrice - input.downPayment;
      double monthlyInterestRate = input.interestRate / 100 / 12;
      int numberOfPayments = years * 12;

      double monthlyPayment = (loanAmount * monthlyInterestRate) /
          (1 - math.pow(1 + monthlyInterestRate, -numberOfPayments));

      return monthlyPayment;
    }

    var listYear = [5, 10, 15, 20, 25, 30];

    if (!listYear.contains(input.loanTerm)) {
      listYear.insert(0, input.loanTerm);
    }
    // listYear.sort();

    print(listYear);
    var listLoan = listYear
        .map((e) => LoanForYear(year: e, installment: calculateKpr(e)))
        .toList();

    // final monthlyInstallment = ((input.propertyPrice - input.downPayment) *
    //         (input.interestRate / 100) *
    //         input.loanTerm) /
    //     (input.loanTerm * 12);
    // var interestPrice = ((input.propertyPrice - input.downPayment));
    // var interestRate = ((input.interestRate / 100) * input.loanTerm);
    // var loanTerm = input.loanTerm * 12;

    // var monthlyPayment = ((input.propertyPrice - input.downPayment) *
    //         ((input.interestRate / 100) * input.loanTerm)) /
    //     input.loanTerm.toDouble() *
    //     12;
    // print(((input.propertyPrice - input.downPayment) *
    //         ((input.interestRate / 100) * input.loanTerm)) /
    //     input.loanTerm.toDouble());
    // double kpr(int years) {
    //   var interestPrice = ((input.propertyPrice - input.downPayment));
    //   var interestRate = (input.interestRate / 100) * input.loanTerm;
    //   var loanTerm = years * 12;

    //   var monthlyPayment = (interestPrice * interestRate) / loanTerm;
    //   print('monthlyPayment: $monthlyPayment');
    //   print('$years');
    //   return monthlyPayment;
    // }

    // for (int year in [5, 10, 15, 20, 25, 30]) {
    //   // final monthlyInterestRate = input.interestRate / 100 / 12;
    //   // final totalMonths = year * 12;
    //   // final powValue = pow(1 + monthlyInterestRate, totalMonths);
    //   // final monthlyPayment = ((input.propertyPrice - input.downPayment) *
    //   //         monthlyInterestRate *
    //   //         powValue) /
    //   //     (powValue - 1);
    // }
    // var listYear = [5, 10, 15, 20, 25, 30];
    // var listLoan =
    //     listYear.map((e) => LoanForYear(year: e, installment: kpr(e))).toList();

    emit(KprLoaded(LoanSimulationResult(
        summaryPrincipalLoan: input.propertyPrice - input.downPayment,
        summaryInterestPrice: ((input.propertyPrice - input.downPayment) *
            (input.interestRate / 100)),
        summaryTotalLoan: (input.propertyPrice - input.downPayment) +
            ((input.propertyPrice - input.downPayment) *
                (input.interestRate / 100)),
        installmentByYear: listLoan)));
  }
  // void dispose() {
  //   emit(KprInitial());
  // }

  void reset() {
    emit(KprInitial());
  }
}
