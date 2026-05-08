import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_ip/bloc/mutual_fund_bloc.dart';
import 'package:mf_ip/models/custom_error.dart';
import 'package:mf_ip/models/mutual_fund.dart';
import 'package:mf_ip/routes/app_routes.dart';

class SchemeListScreen extends StatefulWidget {
  const SchemeListScreen({super.key});

  @override
  State<SchemeListScreen> createState() => _SchemeListScreenState();
}

class _SchemeListScreenState extends State<SchemeListScreen> {
  @override
  void initState() {
    context.read<MutualFundBloc>().add(FetchMutualFunds());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Schemes")),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<MutualFundBloc>().add(FetchMutualFunds());
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by scheme name",
                  prefixIcon: const Icon(Icons.search),
                  // suffixIcon: IconButton(
                  //   onPressed: () {
                  //     context.read<MutualFundBloc>().add(FetchMutualFunds());
                  //   },
                  //   icon: Icon(Icons.close),
                  // ),
                  filled: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                ),
                onChanged: (value) {
                  kPrint("Searchimg mfs of $value");
                  context.read<MutualFundBloc>().add(
                    SearchMutualFunds(userInput: value),
                  );
                },
              ),
            ),
            BlocBuilder<MutualFundBloc, MutualFundState>(
              builder: (context, state) {
                if (state is MutualFundLoading) {
                  return _loadingIndicator();
                }
                if (state is MutualFundError) {
                  return _mfErrorWidget(state.error);
                }
                if (state is MutualFundLoaded) {
                  return _schemesListView(state.schemes);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _mfErrorWidget(CustomException? error) {
    return Center(child: Text(error?.message ?? "Unknown ERROR"));
  }

  Widget _schemesListView(List<MutualFund> schemes) {
    if (schemes.isEmpty) {
      return Center(child: Text("No result found"));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: schemes.length,
        itemBuilder: (context, index) {
          var data = schemes[index];
          return InkWell(
            onTap: () {
              context.push("/scheme-details", extra: {"mf": data});
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.schemeCode != null ? "#${data.schemeCode}" : "",
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.schemeName ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
