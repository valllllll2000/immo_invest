import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'invest_event.dart';

part 'invest_state.dart';

class InvestBloc extends Bloc<InvestEvent, InvestState> {
  InvestBloc() : super(const InvestState()) {
    on<FlatPriceChanged>((event, emit) {
      emit(state.copyWith(
          flatPrice: event.value,
          profitability: _calculateProfitability(
              flatPrice: event.value,
              yearlyExpenses: state.yearlyExpenses,
              mortgageInterest: state.mortgageInterest,
              monthlyRent: state.monthlyRent,
              mortgageDuration: state.mortgageDuration)));
    });

    on<YearlyExpensesChanged>((event, emit) {
      emit(state.copyWith(
          yearlyExpenses: event.value,
          profitability: _calculateProfitability(
              flatPrice: state.flatPrice,
              yearlyExpenses: event.value,
              mortgageInterest: state.mortgageInterest,
              monthlyRent: state.monthlyRent,
              mortgageDuration: state.mortgageDuration)));
    });

    on<MortgageInterestChanged>((event, emit) {
      emit(state.copyWith(
          mortgageInterest: event.value,
          profitability: _calculateProfitability(
              flatPrice: state.flatPrice,
              yearlyExpenses: state.yearlyExpenses,
              mortgageInterest: event.value,
              monthlyRent: state.monthlyRent,
              mortgageDuration: state.mortgageDuration)));
    });

    on<MonthlyRentChanged>((event, emit) {
      emit(state.copyWith(
          monthlyRent: event.value,
          profitability: _calculateProfitability(
              flatPrice: state.flatPrice,
              yearlyExpenses: state.yearlyExpenses,
              mortgageInterest: state.mortgageInterest,
              monthlyRent: event.value,
              mortgageDuration: state.mortgageDuration)));
    });

    on<MortgageDurationChanged>((event, emit) {
      emit(state.copyWith(
         mortgageDuration: event.value,
          profitability: _calculateProfitability(
              flatPrice: state.flatPrice,
              yearlyExpenses: state.yearlyExpenses,
              mortgageInterest: state.mortgageInterest,
              monthlyRent: state.monthlyRent,
              mortgageDuration: event.value)));
    });
  }

  //TODO: format to human readable format max 2 digits after .
  double _calculateProfitability(
      {required double flatPrice,
      required double yearlyExpenses,
      required double mortgageInterest,
      required double monthlyRent,
      required int mortgageDuration}) {
    /**
     * For a secondary residence the bank only gives 70%
     * approx 10% of tax when buying property
     * This means initial investment is minimum 30% of flat price and 10% of
     * tax on flat
     */
    final double investment = (flatPrice * 0.3) + (flatPrice * 0.1);
    final double totalMortgage = flatPrice * 0.7;
    final monthlyMortgageInterest = mortgageInterest / 100 / 12;
    final double totalMonths = mortgageDuration * 12;
    final double monthlyMortgage = (totalMortgage *
            (monthlyMortgageInterest *
                pow((1 + monthlyMortgageInterest), totalMonths))) /
        (pow((1 + monthlyMortgageInterest), totalMonths) - 1);
    print('Monthly mortgage payment: $monthlyMortgage' );
    final double expenses = monthlyMortgage * 12 + yearlyExpenses;
    final double income = monthlyRent * 12;
    return ((income - expenses) / investment) * 100;
  }

  void onFlatPriceChanged(String value) {
    //TODO: verify value is double
    add(FlatPriceChanged(double.parse(value)));
  }

  void onMonthlyRentChanged(String value) {
    //TODO: verify value is double
    add(MonthlyRentChanged(double.parse(value)));
  }

  void onYearlyExpensesChanged(String value) {
    //TODO: verify value is double
    add(YearlyExpensesChanged(double.parse(value)));
  }

  void onMortgageInterestChanged(String value) {
    //TODO: verify value is double
    add(MortgageInterestChanged(double.parse(value)));
  }

  void onMortgageDurationChanged(String value) {
    //TODO: verify value is int
    //min 10 years
    //mas 40 years
    int parse = int.parse(value);
    parse = max(parse, 10);
    parse = min(parse, 40);
    add(MortgageDurationChanged(parse));
  }
}
