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

abstract class SaleItem
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SaleItem._({
    this.id,
    required this.saleId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.purchasePrice,
    required this.discountAmount,
    required this.lineTotal,
    required this.createdAt,
  });

  factory SaleItem({
    int? id,
    required int saleId,
    required int productId,
    required String productName,
    required int quantity,
    required double unitPrice,
    required double purchasePrice,
    required double discountAmount,
    required double lineTotal,
    required DateTime createdAt,
  }) = _SaleItemImpl;

  factory SaleItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return SaleItem(
      id: jsonSerialization['id'] as int?,
      saleId: jsonSerialization['saleId'] as int,
      productId: jsonSerialization['productId'] as int,
      productName: jsonSerialization['productName'] as String,
      quantity: jsonSerialization['quantity'] as int,
      unitPrice: (jsonSerialization['unitPrice'] as num).toDouble(),
      purchasePrice: (jsonSerialization['purchasePrice'] as num).toDouble(),
      discountAmount: (jsonSerialization['discountAmount'] as num).toDouble(),
      lineTotal: (jsonSerialization['lineTotal'] as num).toDouble(),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = SaleItemTable();

  static const db = SaleItemRepository._();

  @override
  int? id;

  int saleId;

  int productId;

  String productName;

  int quantity;

  double unitPrice;

  double purchasePrice;

  double discountAmount;

  double lineTotal;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SaleItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SaleItem copyWith({
    int? id,
    int? saleId,
    int? productId,
    String? productName,
    int? quantity,
    double? unitPrice,
    double? purchasePrice,
    double? discountAmount,
    double? lineTotal,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SaleItem',
      if (id != null) 'id': id,
      'saleId': saleId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'purchasePrice': purchasePrice,
      'discountAmount': discountAmount,
      'lineTotal': lineTotal,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SaleItem',
      if (id != null) 'id': id,
      'saleId': saleId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'purchasePrice': purchasePrice,
      'discountAmount': discountAmount,
      'lineTotal': lineTotal,
      'createdAt': createdAt.toJson(),
    };
  }

  static SaleItemInclude include() {
    return SaleItemInclude._();
  }

  static SaleItemIncludeList includeList({
    _is.WhereExpressionBuilder<SaleItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SaleItemTable>? orderBy,
    _is.OrderByListBuilder<SaleItemTable>? orderByList,
    SaleItemInclude? include,
  }) {
    return SaleItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SaleItem.t),
      orderByList: orderByList?.call(SaleItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SaleItemImpl extends SaleItem {
  _SaleItemImpl({
    int? id,
    required int saleId,
    required int productId,
    required String productName,
    required int quantity,
    required double unitPrice,
    required double purchasePrice,
    required double discountAmount,
    required double lineTotal,
    required DateTime createdAt,
  }) : super._(
         id: id,
         saleId: saleId,
         productId: productId,
         productName: productName,
         quantity: quantity,
         unitPrice: unitPrice,
         purchasePrice: purchasePrice,
         discountAmount: discountAmount,
         lineTotal: lineTotal,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SaleItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SaleItem copyWith({
    Object? id = _Undefined,
    int? saleId,
    int? productId,
    String? productName,
    int? quantity,
    double? unitPrice,
    double? purchasePrice,
    double? discountAmount,
    double? lineTotal,
    DateTime? createdAt,
  }) {
    return SaleItem(
      id: id is int? ? id : this.id,
      saleId: saleId ?? this.saleId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      discountAmount: discountAmount ?? this.discountAmount,
      lineTotal: lineTotal ?? this.lineTotal,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SaleItemUpdateTable extends _is.UpdateTable<SaleItemTable> {
  SaleItemUpdateTable(super.table);

  _is.ColumnValue<int, int> saleId(int value) => _is.ColumnValue(
    table.saleId,
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

  _is.ColumnValue<double, double> unitPrice(double value) => _is.ColumnValue(
    table.unitPrice,
    value,
  );

  _is.ColumnValue<double, double> purchasePrice(double value) =>
      _is.ColumnValue(
        table.purchasePrice,
        value,
      );

  _is.ColumnValue<double, double> discountAmount(double value) =>
      _is.ColumnValue(
        table.discountAmount,
        value,
      );

  _is.ColumnValue<double, double> lineTotal(double value) => _is.ColumnValue(
    table.lineTotal,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class SaleItemTable extends _is.Table<int?> {
  SaleItemTable({super.tableRelation}) : super(tableName: 'sale_item') {
    updateTable = SaleItemUpdateTable(this);
    saleId = _is.ColumnInt(
      'saleId',
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
    unitPrice = _is.ColumnDouble(
      'unitPrice',
      this,
    );
    purchasePrice = _is.ColumnDouble(
      'purchasePrice',
      this,
    );
    discountAmount = _is.ColumnDouble(
      'discountAmount',
      this,
    );
    lineTotal = _is.ColumnDouble(
      'lineTotal',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final SaleItemUpdateTable updateTable;

  late final _is.ColumnInt saleId;

  late final _is.ColumnInt productId;

  late final _is.ColumnString productName;

  late final _is.ColumnInt quantity;

  late final _is.ColumnDouble unitPrice;

  late final _is.ColumnDouble purchasePrice;

  late final _is.ColumnDouble discountAmount;

  late final _is.ColumnDouble lineTotal;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    saleId,
    productId,
    productName,
    quantity,
    unitPrice,
    purchasePrice,
    discountAmount,
    lineTotal,
    createdAt,
  ];
}

class SaleItemInclude extends _is.IncludeObject {
  SaleItemInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SaleItem.t;
}

class SaleItemIncludeList extends _is.IncludeList {
  SaleItemIncludeList._({
    _is.WhereExpressionBuilder<SaleItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SaleItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SaleItem.t;
}

class SaleItemRepository {
  const SaleItemRepository._();

  /// Returns a list of [SaleItem]s matching the given query parameters.
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
  Future<List<SaleItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SaleItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SaleItemTable>? orderBy,
    _is.OrderByListBuilder<SaleItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SaleItem>(
      where: where?.call(SaleItem.t),
      orderBy: orderBy?.call(SaleItem.t),
      orderByList: orderByList?.call(SaleItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SaleItem] matching the given query parameters.
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
  Future<SaleItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SaleItemTable>? where,
    int? offset,
    _is.OrderByBuilder<SaleItemTable>? orderBy,
    _is.OrderByListBuilder<SaleItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SaleItem>(
      where: where?.call(SaleItem.t),
      orderBy: orderBy?.call(SaleItem.t),
      orderByList: orderByList?.call(SaleItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SaleItem] by its [id] or null if no such row exists.
  Future<SaleItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SaleItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SaleItem]s in the list and returns the inserted rows.
  ///
  /// The returned [SaleItem]s will have their `id` fields set.
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
  Future<List<SaleItem>> insert(
    _is.DatabaseSession session,
    List<SaleItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SaleItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SaleItem] and returns the inserted row.
  ///
  /// The returned [SaleItem] will have its `id` field set.
  Future<SaleItem> insertRow(
    _is.DatabaseSession session,
    SaleItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SaleItem>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SaleItem]s in the list and returns the resulting rows.
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
  /// The returned [SaleItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SaleItem>> upsert(
    _is.DatabaseSession session,
    List<SaleItem> rows, {
    required _is.ColumnSelections<SaleItemTable> conflictColumns,
    _is.ColumnSelections<SaleItemTable>? updateColumns,
    _is.WhereExpressionBuilder<SaleItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SaleItem>(
      rows,
      conflictColumns: conflictColumns(SaleItem.t),
      updateColumns: updateColumns?.call(SaleItem.t),
      updateWhere: updateWhere?.call(SaleItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SaleItem] and returns the resulting row.
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
  /// The returned [SaleItem] will have its `id` field set.
  Future<SaleItem?> upsertRow(
    _is.DatabaseSession session,
    SaleItem row, {
    required _is.ColumnSelections<SaleItemTable> conflictColumns,
    _is.ColumnSelections<SaleItemTable>? updateColumns,
    _is.WhereExpressionBuilder<SaleItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SaleItem>(
      row,
      conflictColumns: conflictColumns(SaleItem.t),
      updateColumns: updateColumns?.call(SaleItem.t),
      updateWhere: updateWhere?.call(SaleItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [SaleItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SaleItem>> update(
    _is.DatabaseSession session,
    List<SaleItem> rows, {
    _is.ColumnSelections<SaleItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SaleItem>(
      rows,
      columns: columns?.call(SaleItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SaleItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SaleItem> updateRow(
    _is.DatabaseSession session,
    SaleItem row, {
    _is.ColumnSelections<SaleItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SaleItem>(
      row,
      columns: columns?.call(SaleItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SaleItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SaleItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SaleItemUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SaleItem>(
      id,
      columnValues: columnValues(SaleItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SaleItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SaleItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SaleItemUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SaleItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SaleItemTable>? orderBy,
    _is.OrderByListBuilder<SaleItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SaleItem>(
      columnValues: columnValues(SaleItem.t.updateTable),
      where: where(SaleItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SaleItem.t),
      orderByList: orderByList?.call(SaleItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SaleItem]s in the list and returns the deleted rows.
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
  Future<List<SaleItem>> delete(
    _is.DatabaseSession session,
    List<SaleItem> rows, {
    _is.OrderByBuilder<SaleItemTable>? orderBy,
    _is.OrderByListBuilder<SaleItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SaleItem>(
      rows,
      orderBy: orderBy?.call(SaleItem.t),
      orderByList: orderByList?.call(SaleItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SaleItem].
  Future<SaleItem> deleteRow(
    _is.DatabaseSession session,
    SaleItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SaleItem>(
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
  Future<List<SaleItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SaleItemTable> where,
    _is.OrderByBuilder<SaleItemTable>? orderBy,
    _is.OrderByListBuilder<SaleItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SaleItem>(
      where: where(SaleItem.t),
      orderBy: orderBy?.call(SaleItem.t),
      orderByList: orderByList?.call(SaleItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SaleItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SaleItem>(
      where: where?.call(SaleItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SaleItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SaleItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SaleItem>(
      where: where(SaleItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
