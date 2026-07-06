import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_product_management/presentation/bloc/sync/sync_state.dart';

import 'package:merchant_product_management/presentation/bloc/sync/sync_cubit.dart';
import 'package:merchant_product_management/presentation/pages/product/product_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchant Products'),
        actions: [
          BlocBuilder<SyncCubit, SyncState>(
            builder: (context, state) {
              return Row(
                children: [
                  if (state.isSyncing)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.sync, color: Colors.orange),
                    ),
                  if (!state.isOnline)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.cloud_off, color: Colors.red),
                    ),
                  if (state.pendingCount > 0)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text('${state.pendingCount}'),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: const ProductListPage(),
    );
  }
}