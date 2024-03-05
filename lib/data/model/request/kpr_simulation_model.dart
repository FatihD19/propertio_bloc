class LoanSimulationInput {
  final double propertyPrice;
  final double downPayment;
  final double interestRate;
  final int loanTerm;

  LoanSimulationInput({
    required this.propertyPrice,
    required this.downPayment,
    required this.interestRate,
    required this.loanTerm,
  });
}

class LoanSimulationResult {
  // final double monthlyInstallment;
  final double summaryPrincipalLoan;
  final double summaryInterestPrice;
  final double summaryTotalLoan;
  final Map<int, double> installmentByYear;

  LoanSimulationResult({
    // required this.monthlyInstallment,
    required this.summaryPrincipalLoan,
    required this.summaryInterestPrice,
    required this.summaryTotalLoan,
    required this.installmentByYear,
  });
}
