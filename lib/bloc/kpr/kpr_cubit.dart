import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_bloc/data/model/request/kpr_simulation_model.dart';
import 'dart:math' as math;

part 'kpr_state.dart';

class KprCubit extends Cubit<KprState> {
  KprCubit() : super(KprInitial());
  void calculate(LoanSimulationInput input) {
    if (input.propertyPrice == null || input.propertyPrice! <= 0) {
      emit(KprError("Harga Properti harus diisi"));
      return;
    }
    if (input.downPayment == null || input.downPayment! <= 0) {
      emit(KprError("Uang muka harus diisi"));
      return;
    }
    if (input.downPayment! > input.propertyPrice!) {
      emit(KprError("Uang muka tidak boleh lebih besar dari harga properti"));
      return;
    }
    if (input.interestRate == null || input.interestRate! <= 0) {
      emit(KprError("Suku bunga harus diisi"));
      return;
    }
    if (input.loanTerm == null || input.loanTerm! <= 0) {
      emit(KprError("Jangka waktu harus diisi"));
      return;
    }
    double loanAmount = input.propertyPrice! - input.downPayment!;
    double monthlyInterestRate = input.interestRate! / 100 / 12;
    var listYear = [5, 10, 15, 20, 25, 30];

    if (!listYear.contains(input.loanTerm)) {
      listYear.insert(0, input.loanTerm!);
    }

    print(input.propertyPrice);
    print(input.downPayment);
    print(input.interestRate);
    print(input.loanTerm);

    var listLoan = listYear
        .map((jangkaWaktu) => LoanForYear(
            year: jangkaWaktu,
            installment: (loanAmount * monthlyInterestRate) /
                (1 - math.pow(1 + monthlyInterestRate, -(jangkaWaktu * 12)))))
        .toList();
    print(listLoan.map((e) => e.installment).toList());

    emit(KprLoaded(LoanSimulationResult(
        summaryPrincipalLoan: loanAmount,
        summaryInterestPrice: ((loanAmount) * (input.interestRate! / 100)),
        summaryTotalLoan:
            (loanAmount) + ((loanAmount) * (input.interestRate! / 100)),
        installmentByYear: listLoan)));
    if (input.propertyPrice == 0.0) {
      emit(PropertyPriceEmpty());
    }
  }

  void reset() {
    emit(KprInitial());
  }
}
