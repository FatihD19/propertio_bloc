import 'package:equatable/equatable.dart';

class LoanSimulationInput {
  double? propertyPrice;
  double? downPayment;
  double? interestRate;
  int? loanTerm;

  LoanSimulationInput({
    this.propertyPrice,
    this.downPayment,
    this.interestRate,
    this.loanTerm,
  });
}

class LoanSimulationResult extends Equatable {
  final double? monthlyInstallment;
  final double? summaryPrincipalLoan;
  final double? summaryInterestPrice;
  final double? summaryTotalLoan;
  final List<LoanForYear>? installmentByYear;

  LoanSimulationResult({
    this.monthlyInstallment,
    this.summaryPrincipalLoan,
    this.summaryInterestPrice,
    this.summaryTotalLoan,
    this.installmentByYear,
  });

  @override
  List<Object?> get props => [
        monthlyInstallment,
        summaryPrincipalLoan,
        summaryInterestPrice,
        summaryTotalLoan,
        installmentByYear,
      ];
}

class LoanForYear extends Equatable {
  final int year;
  final double installment;

  LoanForYear({
    required this.year,
    required this.installment,
  });

  @override
  List<Object?> get props => [year, installment];
}
