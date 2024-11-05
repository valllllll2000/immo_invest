part of 'invest_bloc.dart';

//TODO: make sure not zero values
class InvestState extends Equatable {
  final double flatPrice;
  final double monthlyRent;
  final double yearlyExpenses;
  final double mortgageInterest;
  final double profitability;
  final int mortgageDuration;

  const InvestState(
      {this.flatPrice = 95000,
      this.monthlyRent = 550,
      this.yearlyExpenses = 1500,
      this.mortgageInterest = 2.75,
      this.profitability = 4,
      this.mortgageDuration = 25});

  copyWith(
          {double? flatPrice,
          double? yearlyExpenses,
          double? mortgageInterest,
          double? monthlyRent,
          double? profitability,
          int? mortgageDuration}) =>
      InvestState(
          flatPrice: flatPrice ?? this.flatPrice,
          yearlyExpenses: yearlyExpenses ?? this.yearlyExpenses,
          mortgageInterest: mortgageInterest ?? this.mortgageInterest,
          monthlyRent: monthlyRent ?? this.monthlyRent,
          profitability: profitability ?? this.profitability,
          mortgageDuration: mortgageDuration ?? this.mortgageDuration);

  @override
  List<Object> get props => [
        flatPrice,
        yearlyExpenses,
        mortgageInterest,
        monthlyRent,
        profitability,
        mortgageDuration
      ];
}
