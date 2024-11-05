import 'package:flat_invest/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/invest_bloc.dart';
import '../widgets/custom_text_form_field.dart';

class InvestScreen extends StatelessWidget {
  const InvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InvestBloc(),
      child: const SingleChildScrollView(child: _InputForm()),
    );
  }
}

class _InputForm extends StatelessWidget {
  const _InputForm();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
              'I will help you to calculate the profitability of an investment '
              'on a flat, please fill out the form with the information... \n'
              'Default values have been prefilled.'),
          const SizedBox(
            height: 20,
          ),
          context.select((InvestBloc bloc) => CustomTextFormField(
                initialValue: bloc.state.flatPrice.toString(),
                label: 'Flat price',
                onChanged: (value) {
                  context.read<InvestBloc>().onFlatPriceChanged(value);
                },
                maxLength: 10,
              )),
          const SizedBox(
            height: 8,
          ),
          context.select((InvestBloc bloc) => CustomTextFormField(
                initialValue: bloc.state.monthlyRent.toString(),
                label: 'Monthly rent',
                onChanged: (value) {
                  context.read<InvestBloc>().onMonthlyRentChanged(value);
                },
                maxLength: 10,
              )),
          const SizedBox(
            height: 8,
          ),
          context.select((InvestBloc bloc) => CustomTextFormField(
                initialValue: bloc.state.yearlyExpenses.toString(),
                label: 'Yearly expenses',
                onChanged: (value) {
                  context.read<InvestBloc>().onYearlyExpensesChanged(value);
                },
                maxLength: 10,
              )),
          const SizedBox(
            height: 8,
          ),
          context.select((InvestBloc bloc) => CustomTextFormField(
                initialValue: bloc.state.mortgageInterest.toString(),
                label: 'Mortgage interests in %, between 0.5 and 10',
                onChanged: (value) {
                  context.read<InvestBloc>().onMortgageInterestChanged(value);
                },
                maxLength: 4,
              )),
          const SizedBox(
            height: 8,
          ),
          context.select((InvestBloc bloc) => CustomTextFormField(
                initialValue: bloc.state.mortgageDuration.toString(),
                label: 'Mortgage duration in years',
                onChanged: (value) {
                  context.read<InvestBloc>().onMortgageDurationChanged(value);
                },
                maxLength: 2,
              )),
          const SizedBox(
            height: 20,
          ),
          context.select((InvestBloc bloc) => Text(
                'Profitability: ${HumanFormats.number(bloc.state.profitability, 2)} %',
                style: textTheme.titleLarge,
              )),
          const SizedBox(
            height: 20,
          ),
          const Text(
              'Presets: \nFixed rate mortgage, max 40 years, min 10 years. \n10% property value tax, \n70% of the property value is mortgaged, the rest is your capital.'),
        ],
      ),
    );
  }
}
