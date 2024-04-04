import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/model/request/kpr_simulation_model.dart';
import 'dart:math' as math;

part 'kpr_state.dart';

class KprCubit extends Cubit<KprState> {
  KprCubit() : super(KprInitial());
  void calculate(LoanSimulationInput input) {
    // double calculateKpr(int years) {
    //   double loanAmount = input.propertyPrice - input.downPayment;
    //   double monthlyInterestRate = input.interestRate / 100 / 12;
    //   int numberOfPayments = years * 12;

    //   double monthlyPayment = (loanAmount * monthlyInterestRate) /
    //       (1 - math.pow(1 + monthlyInterestRate, -numberOfPayments));

    //   return monthlyPayment;
    // }

    // int numberOfPayments = years * 12;

    // double monthlyPayment = (loanAmount * monthlyInterestRate) /
    //     (1 - math.pow(1 + monthlyInterestRate, -numberOfPayments));
    double loanAmount = input.propertyPrice - input.downPayment;
    double monthlyInterestRate = input.interestRate / 100 / 12;
    var listYear = [5, 10, 15, 20, 25, 30];

    if (!listYear.contains(input.loanTerm)) {
      listYear.insert(0, input.loanTerm);
    }

    print(listYear);
    var listLoan = listYear
        .map((jangkaWaktu) => LoanForYear(
            year: jangkaWaktu,
            installment: (loanAmount * monthlyInterestRate) /
                (1 - math.pow(1 + monthlyInterestRate, -(jangkaWaktu * 12)))))
        .toList();

    emit(KprLoaded(LoanSimulationResult(
        summaryPrincipalLoan: loanAmount,
        summaryInterestPrice: ((loanAmount) * (input.interestRate / 100)),
        summaryTotalLoan:
            (loanAmount) + ((loanAmount) * (input.interestRate / 100)),
        installmentByYear: listLoan)));
  }

  void reset() {
    emit(KprInitial());
  }
}
