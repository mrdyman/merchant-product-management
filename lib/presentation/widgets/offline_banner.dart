import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_product_management/presentation/bloc/sync/sync_state.dart';
import '../bloc/sync/sync_cubit.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncCubit, SyncState>(
      builder: (context, state) {
        if (state.isOnline) return const SizedBox();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'You are offline',
                style: const TextStyle(color: Colors.white),
              ),
              if (state.pendingCount > 0) ...[
                const SizedBox(width: 8),
                Text(
                  '(${state.pendingCount} pending sync)',
                  style: const TextStyle(color: Colors.white),
                ),
              ]
            ],
          ),
        );
      },
    );
  } 
}