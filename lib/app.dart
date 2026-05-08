import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mf_ip/bloc/auth_bloc.dart';
import 'package:mf_ip/bloc/investment_bloc.dart';
import 'package:mf_ip/bloc/mutual_fund_bloc.dart';
import '/routes/app_routes.dart';
import 'bloc/mutual_fund_history_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MutualFundBloc()),
        BlocProvider(create: (_) => MutualFundHistoryBloc()),
        BlocProvider(create: (_) => AuthBloc()..add(CheckAuthStatus())),
        BlocProvider(create: (_) => InvestmentBloc()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        routerConfig: routerConfig,
      ),
    );
  }
}
