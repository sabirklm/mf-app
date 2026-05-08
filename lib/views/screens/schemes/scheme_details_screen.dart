import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_ip/bloc/mutual_fund_history_bloc.dart';
import 'package:mf_ip/models/mutual_fund.dart';
import 'package:mf_ip/models/nav_history.dart';
import 'package:mf_ip/service/endpoints.dart';
import 'package:mf_ip/views/widgets/custom_button.dart';
import 'package:mf_ip/views/widgets/custom_snackbar.dart';

import '../../../bloc/investment_bloc.dart';

class SchemeDetailsScreen extends StatefulWidget {
  final MutualFund mf;
  const SchemeDetailsScreen({super.key, required this.mf});

  @override
  State<SchemeDetailsScreen> createState() => _SchemeDetailsScreenState();
}

class _SchemeDetailsScreenState extends State<SchemeDetailsScreen> {
  @override
  void initState() {
    context.read<MutualFundHistoryBloc>().add(
      FetchMutualFundHistory(id: "${widget.mf.schemeCode}"),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.mf.schemeName ?? "")
      ),
      body: BlocBuilder<MutualFundHistoryBloc, MutualFundHistoryState>(
        builder: (context, state) {
          if (state is MutualFundHistoryLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        widget.mf.schemeName ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      ...List.generate(state.navHistory.data?.length ?? 0, (
                        index,
                      ) {
                        var navData = state.navHistory.data![index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                navData.nav ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              Text(
                                navData.date ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SafeArea(
                    child: CustomAppButton(
                      title: "Invest Now",
                      color: Colors.green,
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return InvestNowWidget(mf: widget.mf);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}

class InvestNowWidget extends StatefulWidget {
  final MutualFund mf;
  const InvestNowWidget({super.key, required this.mf});

  @override
  State<InvestNowWidget> createState() => _InvestNowWidgetState();
}

class _InvestNowWidgetState extends State<InvestNowWidget> {
  final _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: BlocConsumer<InvestmentBloc, InvestmentState>(
        listener: (context, state) {
          if (state.status == CurrentInvestmentStatus.invested) {
            CustomSnackBar.show(context, message: "Investment successful");
            context.pop();
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Invest now",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Please enter the amount",
                ),
              ),
              const SizedBox(height: 4),
              Text("Minium amount must be 100"),
              const SizedBox(height: 16),
              if (state.status == CurrentInvestmentStatus.investing)
                Center(child: CircularProgressIndicator())
              else
                SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomAppButton(
                          title: "Cancel",
                          color: Colors.grey,
                          onTap: () {
                            context.pop();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomAppButton(
                          title: "Confirm",
                          color: Colors.red.shade400,
                          onTap: onInvest,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  void onInvest() {
    if (_amountController.text.trim().isEmpty) {
      CustomSnackBar.show(context, message: "Please enter a valid amount!");
      return;
    }
    var amount = double.tryParse(_amountController.text);
    if (amount == null) {
      CustomSnackBar.show(context, message: "Please enter a valid amount!");
      return;
    }
    if (amount < 100) {
      CustomSnackBar.show(context, message: "Minimum amount should be ₹100");
      return;
    }
    context.read<InvestmentBloc>().add(
      InvestNow(amount: amount, mfIf: "${widget.mf.schemeCode}"),
    );
  }
}
