import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/model/request/kpr_simulation_model.dart';
import 'dart:math' as math;

part 'kpr_state.dart';

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
