import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:propertio_bloc/bloc/kpr/kpr_cubit.dart';
import 'package:propertio_bloc/data/model/request/kpr_simulation_model.dart';
import 'dart:math' as math;

// Matcher equalsLoanSimulationResult(LoanSimulationResult expected) {
//   //menggunakan matcher agar benar-benar membandingkan nilai yang sama meski berbeda instance
//   return allOf(
//     predicate<LoanSimulationResult>(
//         (result) =>
//             result.summaryPrincipalLoan == expected.summaryPrincipalLoan,
//         'summaryPrincipalLoan matches'),
//     predicate<LoanSimulationResult>(
//         (result) =>
//             result.summaryInterestPrice == expected.summaryInterestPrice,
//         'summaryInterestPrice matches'),
//     predicate<LoanSimulationResult>(
//         (result) => result.summaryTotalLoan == expected.summaryTotalLoan,
//         'summaryTotalLoan matches'),
//     predicate<LoanSimulationResult>((result) {
//       if (result.installmentByYear!.length !=
//           expected.installmentByYear!.length) {
//         return false;
//       }
//       for (int i = 0; i < result.installmentByYear!.length; i++) {
//         if (result.installmentByYear![i].year !=
//                 expected.installmentByYear![i].year ||
//             result.installmentByYear![i].installment !=
//                 expected.installmentByYear![i].installment) {
//           return false;
//         }
//       }
//       return true;
//     }, 'installmentByYear matches'),
//   );
// }

// void main() {
//   group('KprCubit', () {
//     late KprCubit kprCubit;

//     setUp(() {
//       kprCubit = KprCubit();
//     });

//     tearDown(() {
//       kprCubit.close();
//     });

//     test('initial state is KprInitial', () {
//       expect(kprCubit.state, KprInitial());
//     });

//     final input = LoanSimulationInput(
//       propertyPrice: 500000000.0,
//       downPayment: 100000000.0,
//       interestRate: 7.0,
//       loanTerm: 20,
//     );
//     final summaryPrincipalLoan = input.propertyPrice - input.downPayment;

//     final kprResult = LoanSimulationResult(
//       summaryPrincipalLoan: summaryPrincipalLoan,
//       summaryInterestPrice:
//           ((summaryPrincipalLoan) * (input.interestRate / 100)),
//       summaryTotalLoan: (summaryPrincipalLoan) +
//           ((summaryPrincipalLoan) * (input.interestRate / 100)),
//       installmentByYear: [
//         LoanForYear(year: 5, installment: 7920479.416139789),
//         LoanForYear(year: 10, installment: 4644339.168744951),
//         LoanForYear(year: 15, installment: 3595313.0834096996),
//         LoanForYear(year: 20, installment: 3101195.7424754924),
//         LoanForYear(year: 25, installment: 2827116.789100363),
//         LoanForYear(year: 30, installment: 2661209.9807167295),
//       ],
//     );

//     blocTest<KprCubit, KprState>(
//       'emits KprLoaded when calculate is called with valid input',
//       build: () => kprCubit,
//       act: (cubit) => cubit.calculate(input),
//       expect: () => [
//         isA<KprLoaded>().having(
//           (state) => state.installmentResults,
//           'installmentResults',
//           equalsLoanSimulationResult(kprResult),
//         ),
//       ],
//     );

//     blocTest<KprCubit, KprState>(
//       'resets to KprInitial when reset is called',
//       build: () => kprCubit,
//       act: (cubit) => cubit.reset(),
//       expect: () => [KprInitial()],
//     );
//   });
// }

void main() {
  EquatableConfig.stringify = true;

  group('KprCubit', () {
    late KprCubit kprCubit;

    setUp(() {
      kprCubit = KprCubit();
    });

    tearDown(() {
      kprCubit.close();
    });

    test('initial state is KprInitial', () {
      expect(kprCubit.state, KprInitial());
    });

    final input = LoanSimulationInput(
      propertyPrice: 500000000.0,
      downPayment: 100000000.0,
      interestRate: 7.0,
      loanTerm: 20,
    );

    final summaryPrincipalLoan = input.propertyPrice! - input.downPayment!;

    final propertyPriceNull = LoanSimulationInput(
      downPayment: 100000000.0,
      interestRate: 7.0,
      loanTerm: 20,
    );

    final downPaymentNull = LoanSimulationInput(
      propertyPrice: 500000000.0,
      interestRate: 7.0,
      loanTerm: 20,
    );

    final downPaymentMoreThanPropertyPrice = LoanSimulationInput(
      propertyPrice: 500000000.0,
      downPayment: 600000000.0,
      interestRate: 7.0,
      loanTerm: 20,
    );

    final interestRateNull = LoanSimulationInput(
      propertyPrice: 500000000.0,
      downPayment: 100000000.0,
      loanTerm: 20,
    );

    final loanTermNull = LoanSimulationInput(
      propertyPrice: 500000000.0,
      downPayment: 100000000.0,
      interestRate: 7.0,
    );

    final kprResult = LoanSimulationResult(
      summaryPrincipalLoan: summaryPrincipalLoan,
      summaryInterestPrice:
          ((summaryPrincipalLoan) * (input.interestRate! / 100)),
      summaryTotalLoan: (summaryPrincipalLoan) +
          ((summaryPrincipalLoan) * (input.interestRate! / 100)),
      installmentByYear: [
        LoanForYear(year: 5, installment: 7920479.416139789),
        LoanForYear(year: 10, installment: 4644339.168744951),
        LoanForYear(year: 15, installment: 3595313.0834096996),
        LoanForYear(year: 20, installment: 3101195.7424754924),
        LoanForYear(year: 25, installment: 2827116.789100363),
        LoanForYear(year: 30, installment: 2661209.9807167295),
      ],
    );

    blocTest<KprCubit, KprState>(
      'emits KprLoaded when calculate is called with valid input',
      build: () => kprCubit,
      act: (cubit) => cubit.calculate(input),
      expect: () => [
        KprLoaded(kprResult),
      ],
    );

    blocTest<KprCubit, KprState>(
      'emits KprError when calculate is called with propertyPrice null',
      build: () => kprCubit,
      act: (cubit) => cubit.calculate(propertyPriceNull),
      expect: () => [
        KprError("Harga Properti harus diisi"),
      ],
    );

    blocTest<KprCubit, KprState>(
      'emits KprError when calculate is called with downPayment null',
      build: () => kprCubit,
      act: (cubit) => cubit.calculate(downPaymentNull),
      expect: () => [
        KprError("Uang muka harus diisi"),
      ],
    );

    blocTest<KprCubit, KprState>(
      'emits KprError when calculate is called with downPayment more than propertyPrice',
      build: () => kprCubit,
      act: (cubit) => cubit.calculate(downPaymentMoreThanPropertyPrice),
      expect: () => [
        KprError("Uang muka tidak boleh lebih besar dari harga properti"),
      ],
    );

    blocTest<KprCubit, KprState>(
      'emits KprError when calculate is called with interestRate null',
      build: () => kprCubit,
      act: (cubit) => cubit.calculate(interestRateNull),
      expect: () => [
        KprError("Suku bunga harus diisi"),
      ],
    );

    blocTest<KprCubit, KprState>(
      'emits KprError when calculate is called with loanTerm null',
      build: () => kprCubit,
      act: (cubit) => cubit.calculate(loanTermNull),
      expect: () => [
        KprError("Jangka waktu harus diisi"),
      ],
    );

    blocTest<KprCubit, KprState>(
      'resets to KprInitial when reset is called',
      build: () => kprCubit,
      act: (cubit) => cubit.reset(),
      expect: () => [KprInitial()],
    );
  });
}
