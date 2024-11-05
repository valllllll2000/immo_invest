part of 'invest_bloc.dart';

abstract class InvestEvent {
  const InvestEvent();
}

class FlatPriceChanged extends InvestEvent {
  final double value;

  FlatPriceChanged(this.value);
}

class YearlyExpensesChanged extends InvestEvent {
  final double value;

  YearlyExpensesChanged(this.value);
}

class MortgageInterestChanged extends InvestEvent {
  final double value;

  MortgageInterestChanged(this.value);
}

class MonthlyRentChanged extends InvestEvent {
  final double value;

  MonthlyRentChanged(this.value);
}

class MortgageDurationChanged extends InvestEvent {
  final int value;

  MortgageDurationChanged(this.value);
}
