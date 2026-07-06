enum PendingOperationType {
  create,
  update,
}

extension PendingOperationTypeX on PendingOperationType {
  String get value {
    switch (this) {
      case PendingOperationType.create:
        return 'create';
      case PendingOperationType.update:
        return 'update';
    }
  }

  static PendingOperationType fromValue(String value) {
    switch (value) {
      case 'create':
        return PendingOperationType.create;
      case 'update':
        return PendingOperationType.update;
      default:
        throw ArgumentError('Unknown operation: $value');
    }
  }
}