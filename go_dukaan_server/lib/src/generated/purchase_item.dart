/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

abstract class PurchaseItem
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PurchaseItem._({
    this.id,
    required this.purchaseId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPurchasePrice,
    required this.lineTotal,
  });

  factory PurchaseItem({
    int? id,
    required int purchaseId,
    required int productId,
    required String productName,
    required int quantity,
    required double unitPurchasePrice,
    required double lineTotal,
  }) = _PurchaseItemImpl;

  factory PurchaseItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return PurchaseItem(
      id: jsonSerialization['id'] as int?,
      purchaseId: jsonSerialization['purchaseId'] as int,
      productId: jsonSerialization['productId'] as int,
      productName: jsonSerialization['productName'] as String,
      quantity: jsonSerialization['quantity'] as int,
      unitPurchasePrice: (jsonSerialization['unitPurchasePrice'] as num)
          .toDouble(),
      lineTotal: (jsonSerialization['lineTotal'] as num).toDouble(),
    );
  }

  static final t = PurchaseItemTable();

  static const db = PurchaseItemRepository._();

  @override
  int? id;

  int purchaseId;

  int productId;

  String productName;

  int quantity;

  double unitPurchasePrice;

  double lineTotal;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PurchaseItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PurchaseItem copyWith({
    int? id,
    int? purchaseId,
    int? productId,
    String? productName,
    int? quantity,
    double? unitPurchasePrice,
    double? lineTotal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PurchaseItem',
      if (id != null) 'id': id,
      'purchaseId': purchaseId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPurchasePrice': unitPurchasePrice,
      'lineTotal': lineTotal,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PurchaseItem',
      if (id != null) 'id': id,
      'purchaseId': purchaseId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPurchasePrice': unitPurchasePrice,
      'lineTotal': lineTotal,
    };
  }

  static PurchaseItemInclude include() {
    return PurchaseItemInclude._();
  }

  static PurchaseItemIncludeList includeList({
    _is.WhereExpressionBuilder<PurchaseItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PurchaseItemTable>? orderBy,
    _is.OrderByListBuilder<PurchaseItemTable>? orderByList,
    PurchaseItemInclude? include,
  }) {
    return PurchaseItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PurchaseItem.t),
      orderByList: orderByList?.call(PurchaseItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PurchaseItemImpl extends PurchaseItem {
  _PurchaseItemImpl({
    int? id,
    required int purchaseId,
    required int productId,
    required String productName,
    required int quantity,
    required double unitPurchasePrice,
    required double lineTotal,
  }) : super._(
         id: id,
         purchaseId: purchaseId,
         productId: productId,
         productName: productName,
         quantity: quantity,
         unitPurchasePrice: unitPurchasePrice,
         lineTotal: lineTotal,
       );

  /// Returns a shallow copy of this [PurchaseItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PurchaseItem copyWith({
    Object? id = _Undefined,
    int? purchaseId,
    int? productId,
    String? productName,
    int? quantity,
    double? unitPurchasePrice,
    double? lineTotal,
  }) {
    return PurchaseItem(
      id: id is int? ? id : this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPurchasePrice: unitPurchasePrice ?? this.unitPurchasePrice,
      lineTotal: lineTotal ?? this.lineTotal,
    );
  }
}

class PurchaseItemUpdateTable extends _is.UpdateTable<PurchaseItemTable> {
  PurchaseItemUpdateTable(super.table);

  _is.ColumnValue<int, int> purchaseId(int value) => _is.ColumnValue(
    table.purchaseId,
    value,
  );

  _is.ColumnValue<int, int> productId(int value) => _is.ColumnValue(
    table.productId,
    value,
  );

  _is.ColumnValue<String, String> productName(String value) => _is.ColumnValue(
    table.productName,
    value,
  );

  _is.ColumnValue<int, int> quantity(int value) => _is.ColumnValue(
    table.quantity,
    value,
  );

  _is.ColumnValue<double, double> unitPurchasePrice(double value) =>
      _is.ColumnValue(
        table.unitPurchasePrice,
        value,
      );

  _is.ColumnValue<double, double> lineTotal(double value) => _is.ColumnValue(
    table.lineTotal,
    value,
  );
}

class PurchaseItemTable extends _is.Table<int?> {
  PurchaseItemTable({super.tableRelation})
    : super(tableName: 'purchase_items') {
    updateTable = PurchaseItemUpdateTable(this);
    purchaseId = _is.ColumnInt(
      'purchaseId',
      this,
    );
    productId = _is.ColumnInt(
      'productId',
      this,
    );
    productName = _is.ColumnString(
      'productName',
      this,
    );
    quantity = _is.ColumnInt(
      'quantity',
      this,
    );
    unitPurchasePrice = _is.ColumnDouble(
      'unitPurchasePrice',
      this,
    );
    lineTotal = _is.ColumnDouble(
      'lineTotal',
      this,
    );
  }

  late final PurchaseItemUpdateTable updateTable;

  late final _is.ColumnInt purchaseId;

  late final _is.ColumnInt productId;

  late final _is.ColumnString productName;

  late final _is.ColumnInt quantity;

  late final _is.ColumnDouble unitPurchasePrice;

  late final _is.ColumnDouble lineTotal;

  @override
  List<_is.Column> get columns => [
    id,
    purchaseId,
    productId,
    productName,
    quantity,
    unitPurchasePrice,
    lineTotal,
  ];
}

class PurchaseItemInclude extends _is.IncludeObject {
  PurchaseItemInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PurchaseItem.t;
}

class PurchaseItemIncludeList extends _is.IncludeList {
  PurchaseItemIncludeList._({
    _is.WhereExpressionBuilder<PurchaseItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PurchaseItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PurchaseItem.t;
}

class PurchaseItemRepository {
  const PurchaseItemRepository._();

  /// Returns a list of [PurchaseItem]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<PurchaseItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PurchaseItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PurchaseItemTable>? orderBy,
    _is.OrderByListBuilder<PurchaseItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PurchaseItem>(
      where: where?.call(PurchaseItem.t),
      orderBy: orderBy?.call(PurchaseItem.t),
      orderByList: orderByList?.call(PurchaseItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PurchaseItem] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<PurchaseItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PurchaseItemTable>? where,
    int? offset,
    _is.OrderByBuilder<PurchaseItemTable>? orderBy,
    _is.OrderByListBuilder<PurchaseItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PurchaseItem>(
      where: where?.call(PurchaseItem.t),
      orderBy: orderBy?.call(PurchaseItem.t),
      orderByList: orderByList?.call(PurchaseItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PurchaseItem] by its [id] or null if no such row exists.
  Future<PurchaseItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PurchaseItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PurchaseItem]s in the list and returns the inserted rows.
  ///
  /// The returned [PurchaseItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PurchaseItem>> insert(
    _is.DatabaseSession session,
    List<PurchaseItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PurchaseItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PurchaseItem] and returns the inserted row.
  ///
  /// The returned [PurchaseItem] will have its `id` field set.
  Future<PurchaseItem> insertRow(
    _is.DatabaseSession session,
    PurchaseItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PurchaseItem>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PurchaseItem]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [PurchaseItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PurchaseItem>> upsert(
    _is.DatabaseSession session,
    List<PurchaseItem> rows, {
    required _is.ColumnSelections<PurchaseItemTable> conflictColumns,
    _is.ColumnSelections<PurchaseItemTable>? updateColumns,
    _is.WhereExpressionBuilder<PurchaseItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PurchaseItem>(
      rows,
      conflictColumns: conflictColumns(PurchaseItem.t),
      updateColumns: updateColumns?.call(PurchaseItem.t),
      updateWhere: updateWhere?.call(PurchaseItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PurchaseItem] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [PurchaseItem] will have its `id` field set.
  Future<PurchaseItem?> upsertRow(
    _is.DatabaseSession session,
    PurchaseItem row, {
    required _is.ColumnSelections<PurchaseItemTable> conflictColumns,
    _is.ColumnSelections<PurchaseItemTable>? updateColumns,
    _is.WhereExpressionBuilder<PurchaseItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PurchaseItem>(
      row,
      conflictColumns: conflictColumns(PurchaseItem.t),
      updateColumns: updateColumns?.call(PurchaseItem.t),
      updateWhere: updateWhere?.call(PurchaseItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [PurchaseItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PurchaseItem>> update(
    _is.DatabaseSession session,
    List<PurchaseItem> rows, {
    _is.ColumnSelections<PurchaseItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PurchaseItem>(
      rows,
      columns: columns?.call(PurchaseItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PurchaseItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PurchaseItem> updateRow(
    _is.DatabaseSession session,
    PurchaseItem row, {
    _is.ColumnSelections<PurchaseItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PurchaseItem>(
      row,
      columns: columns?.call(PurchaseItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PurchaseItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PurchaseItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PurchaseItemUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PurchaseItem>(
      id,
      columnValues: columnValues(PurchaseItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PurchaseItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PurchaseItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PurchaseItemUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PurchaseItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PurchaseItemTable>? orderBy,
    _is.OrderByListBuilder<PurchaseItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PurchaseItem>(
      columnValues: columnValues(PurchaseItem.t.updateTable),
      where: where(PurchaseItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PurchaseItem.t),
      orderByList: orderByList?.call(PurchaseItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PurchaseItem]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PurchaseItem>> delete(
    _is.DatabaseSession session,
    List<PurchaseItem> rows, {
    _is.OrderByBuilder<PurchaseItemTable>? orderBy,
    _is.OrderByListBuilder<PurchaseItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PurchaseItem>(
      rows,
      orderBy: orderBy?.call(PurchaseItem.t),
      orderByList: orderByList?.call(PurchaseItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PurchaseItem].
  Future<PurchaseItem> deleteRow(
    _is.DatabaseSession session,
    PurchaseItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PurchaseItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PurchaseItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PurchaseItemTable> where,
    _is.OrderByBuilder<PurchaseItemTable>? orderBy,
    _is.OrderByListBuilder<PurchaseItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PurchaseItem>(
      where: where(PurchaseItem.t),
      orderBy: orderBy?.call(PurchaseItem.t),
      orderByList: orderByList?.call(PurchaseItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PurchaseItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PurchaseItem>(
      where: where?.call(PurchaseItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PurchaseItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PurchaseItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PurchaseItem>(
      where: where(PurchaseItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
