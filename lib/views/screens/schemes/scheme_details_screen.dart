import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_ip/bloc/mutual_fund_history_bloc.dart';
import 'package:mf_ip/models/mutual_fund.dart';
import 'package:mf_ip/views/widgets/custom_button.dart';

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
                  child: CustomAppButton(
                    title: "Invest Now",
                    color: Colors.green,
                    onTap: () {
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Invest now",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
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
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Please enter the amount",
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text("Minium amount must be 100"),
                                const SizedBox(height: 16),
                                Row(
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
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                        },
                      );
                    },
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
