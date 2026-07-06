import 'package:equatable/equatable.dart';

class SyncState extends Equatable {
  final bool isOnline;
  final bool isSyncing;
  final int pendingCount;

  const SyncState({
    required this.isOnline,
    required this.isSyncing,
    required this.pendingCount,
  });

  factory SyncState.initial() {
    return const SyncState(
      isOnline: true,
      isSyncing: false,
      pendingCount: 0,
    );
  }

  SyncState copyWith({
    bool? isOnline,
    bool? isSyncing,
    int? pendingCount,
  }) {
    return SyncState(
      isOnline: isOnline ?? this.isOnline,
      isSyncing: isSyncing ?? this.isSyncing,
      pendingCount: pendingCount ?? this.pendingCount,
    );
  }

  @override
  List<Object?> get props => [
        isOnline,
        isSyncing,
        pendingCount,
      ];
}