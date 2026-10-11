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

abstract class Sale implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Sale._({
    this.id,
    required this.shopId,
    this.customerId,
    required this.invoiceNumber,
    required this.subtotal,
    required this.discountAmount,
    required this.taxAmount,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.paymentMethod,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sale({
    int? id,
    required int shopId,
    int? customerId,
    required String invoiceNumber,
    required double subtotal,
    required double discountAmount,
    required double taxAmount,
    required double totalAmount,
    required double paidAmount,
    required double dueAmount,
    required String paymentMethod,
    required String status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SaleImpl;

  factory Sale.fromJson(Map<String, dynamic> jsonSerialization) {
    return Sale(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      customerId: jsonSerialization['customerId'] as int?,
      invoiceNumber: jsonSerialization['invoiceNumber'] as String,
      subtotal: (jsonSerialization['subtotal'] as num).toDouble(),
      discountAmount: (jsonSerialization['discountAmount'] as num).toDouble(),
      taxAmount: (jsonSerialization['taxAmount'] as num).toDouble(),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      paidAmount: (jsonSerialization['paidAmount'] as num).toDouble(),
      dueAmount: (jsonSerialization['dueAmount'] as num).toDouble(),
      paymentMethod: jsonSerialization['paymentMethod'] as String,
      status: jsonSerialization['status'] as String,
      notes: jsonSerialization['notes'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = SaleTable();

  static const db = SaleRepository._();

  @override
  int? id;

  int shopId;

  int? customerId;

  String invoiceNumber;

  double subtotal;

  double discountAmount;

  double taxAmount;

  double totalAmount;

  double paidAmount;

  double dueAmount;

  String paymentMethod;

  String status;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Sale]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Sale copyWith({
    int? id,
    int? shopId,
    int? customerId,
    String? invoiceNumber,
    double? subtotal,
    double? discountAmount,
    double? taxAmount,
    double? totalAmount,
    double? paidAmount,
    double? dueAmount,
    String? paymentMethod,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Sale',
      if (id != null) 'id': id,
      'shopId': shopId,
      if (customerId != null) 'customerId': customerId,
      'invoiceNumber': invoiceNumber,
      'subtotal': subtotal,
      'discountAmount': discountAmount,
      'taxAmount': taxAmount,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'paymentMethod': paymentMethod,
      'status': status,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Sale',
      if (id != null) 'id': id,
      'shopId': shopId,
      if (customerId != null) 'customerId': customerId,
      'invoiceNumber': invoiceNumber,
      'subtotal': subtotal,
      'discountAmount': discountAmount,
      'taxAmount': taxAmount,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'paymentMethod': paymentMethod,
      'status': status,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SaleInclude include() {
    return SaleInclude._();
  }

  static SaleIncludeList includeList({
    _is.WhereExpressionBuilder<SaleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SaleTable>? orderBy,
    _is.OrderByListBuilder<SaleTable>? orderByList,
    SaleInclude? include,
  }) {
    return SaleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Sale.t),
      orderByList: orderByList?.call(Sale.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SaleImpl extends Sale {
  _SaleImpl({
    int? id,
    required int shopId,
    int? customerId,
    required String invoiceNumber,
    required double subtotal,
    required double discountAmount,
    required double taxAmount,
    required double totalAmount,
    required double paidAmount,
    required double dueAmount,
    required String paymentMethod,
    required String status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         shopId: shopId,
         customerId: customerId,
         invoiceNumber: invoiceNumber,
         subtotal: subtotal,
         discountAmount: discountAmount,
         taxAmount: taxAmount,
         totalAmount: totalAmount,
         paidAmount: paidAmount,
         dueAmount: dueAmount,
         paymentMethod: paymentMethod,
         status: status,
         notes: notes,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Sale]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Sale copyWith({
    Object? id = _Undefined,
    int? shopId,
    Object? customerId = _Undefined,
    String? invoiceNumber,
    double? subtotal,
    double? discountAmount,
    double? taxAmount,
    double? totalAmount,
    double? paidAmount,
    double? dueAmount,
    String? paymentMethod,
    String? status,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Sale(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      customerId: customerId is int? ? customerId : this.customerId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      subtotal: subtotal ?? this.subtotal,
      discountAmount: discountAmount ?? this.discountAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SaleUpdateTable extends _is.UpdateTable<SaleTable> {
  SaleUpdateTable(super.table);

  _is.ColumnValue<int, int> shopId(int value) => _is.ColumnValue(
    table.shopId,
    value,
  );

  _is.ColumnValue<int, int> customerId(int? value) => _is.ColumnValue(
    table.customerId,
    value,
  );

  _is.ColumnValue<String, String> invoiceNumber(String value) =>
      _is.ColumnValue(
        table.invoiceNumber,
        value,
      );

  _is.ColumnValue<double, double> subtotal(double value) => _is.ColumnValue(
    table.subtotal,
    value,
  );

  _is.ColumnValue<double, double> discountAmount(double value) =>
      _is.ColumnValue(
        table.discountAmount,
        value,
      );

  _is.ColumnValue<double, double> taxAmount(double value) => _is.ColumnValue(
    table.taxAmount,
    value,
  );

  _is.ColumnValue<double, double> totalAmount(double value) => _is.ColumnValue(
    table.totalAmount,
    value,
  );

  _is.ColumnValue<double, double> paidAmount(double value) => _is.ColumnValue(
    table.paidAmount,
    value,
  );

  _is.ColumnValue<double, double> dueAmount(double value) => _is.ColumnValue(
    table.dueAmount,
    value,
  );

  _is.ColumnValue<String, String> paymentMethod(String value) =>
      _is.ColumnValue(
        table.paymentMethod,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class SaleTable extends _is.Table<int?> {
  SaleTable({super.tableRelation}) : super(tableName: 'sale') {
    updateTable = SaleUpdateTable(this);
    shopId = _is.ColumnInt(
      'shopId',
      this,
    );
    customerId = _is.ColumnInt(
      'customerId',
      this,
    );
    invoiceNumber = _is.ColumnString(
      'invoiceNumber',
      this,
    );
    subtotal = _is.ColumnDouble(
      'subtotal',
      this,
    );
    discountAmount = _is.ColumnDouble(
      'discountAmount',
      this,
    );
    taxAmount = _is.ColumnDouble(
      'taxAmount',
      this,
    );
    totalAmount = _is.ColumnDouble(
      'totalAmount',
      this,
    );
    paidAmount = _is.ColumnDouble(
      'paidAmount',
      this,
    );
    dueAmount = _is.ColumnDouble(
      'dueAmount',
      this,
    );
    paymentMethod = _is.ColumnString(
      'paymentMethod',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final SaleUpdateTable updateTable;

  late final _is.ColumnInt shopId;

  late final _is.ColumnInt customerId;

  late final _is.ColumnString invoiceNumber;

  late final _is.ColumnDouble subtotal;

  late final _is.ColumnDouble discountAmount;

  late final _is.ColumnDouble taxAmount;

  late final _is.ColumnDouble totalAmount;

  late final _is.ColumnDouble paidAmount;

  late final _is.ColumnDouble dueAmount;

  late final _is.ColumnString paymentMethod;

  late final _is.ColumnString status;

  late final _is.ColumnString notes;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    shopId,
    customerId,
    invoiceNumber,
    subtotal,
    discountAmount,
    taxAmount,
    totalAmount,
    paidAmount,
    dueAmount,
    paymentMethod,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
}

class SaleInclude extends _is.IncludeObject {
  SaleInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Sale.t;
}

class SaleIncludeList extends _is.IncludeList {
  SaleIncludeList._({
    _is.WhereExpressionBuilder<SaleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Sale.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Sale.t;
}

class SaleRepository {
  const SaleRepository._();

  /// Returns a list of [Sale]s matching the given query parameters.
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
  Future<List<Sale>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SaleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SaleTable>? orderBy,
    _is.OrderByListBuilder<SaleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Sale>(
      where: where?.call(Sale.t),
      orderBy: orderBy?.call(Sale.t),
      orderByList: orderByList?.call(Sale.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Sale] matching the given query parameters.
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
  Future<Sale?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SaleTable>? where,
    int? offset,
    _is.OrderByBuilder<SaleTable>? orderBy,
    _is.OrderByListBuilder<SaleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Sale>(
      where: where?.call(Sale.t),
      orderBy: orderBy?.call(Sale.t),
      orderByList: orderByList?.call(Sale.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Sale] by its [id] or null if no such row exists.
  Future<Sale?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Sale>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Sale]s in the list and returns the inserted rows.
  ///
  /// The returned [Sale]s will have their `id` fields set.
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
  Future<List<Sale>> insert(
    _is.DatabaseSession session,
    List<Sale> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Sale>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Sale] and returns the inserted row.
  ///
  /// The returned [Sale] will have its `id` field set.
  Future<Sale> insertRow(
    _is.DatabaseSession session,
    Sale row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Sale>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Sale]s in the list and returns the resulting rows.
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
  /// The returned [Sale]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Sale>> upsert(
    _is.DatabaseSession session,
    List<Sale> rows, {
    required _is.ColumnSelections<SaleTable> conflictColumns,
    _is.ColumnSelections<SaleTable>? updateColumns,
    _is.WhereExpressionBuilder<SaleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Sale>(
      rows,
      conflictColumns: conflictColumns(Sale.t),
      updateColumns: updateColumns?.call(Sale.t),
      updateWhere: updateWhere?.call(Sale.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Sale] and returns the resulting row.
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
  /// The returned [Sale] will have its `id` field set.
  Future<Sale?> upsertRow(
    _is.DatabaseSession session,
    Sale row, {
    required _is.ColumnSelections<SaleTable> conflictColumns,
    _is.ColumnSelections<SaleTable>? updateColumns,
    _is.WhereExpressionBuilder<SaleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Sale>(
      row,
      conflictColumns: conflictColumns(Sale.t),
      updateColumns: updateColumns?.call(Sale.t),
      updateWhere: updateWhere?.call(Sale.t),
      transaction: transaction,
    );
  }

  /// Updates all [Sale]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Sale>> update(
    _is.DatabaseSession session,
    List<Sale> rows, {
    _is.ColumnSelections<SaleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Sale>(
      rows,
      columns: columns?.call(Sale.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Sale]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Sale> updateRow(
    _is.DatabaseSession session,
    Sale row, {
    _is.ColumnSelections<SaleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Sale>(
      row,
      columns: columns?.call(Sale.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Sale] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Sale?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SaleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Sale>(
      id,
      columnValues: columnValues(Sale.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Sale]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Sale>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SaleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SaleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SaleTable>? orderBy,
    _is.OrderByListBuilder<SaleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Sale>(
      columnValues: columnValues(Sale.t.updateTable),
      where: where(Sale.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Sale.t),
      orderByList: orderByList?.call(Sale.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Sale]s in the list and returns the deleted rows.
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
  Future<List<Sale>> delete(
    _is.DatabaseSession session,
    List<Sale> rows, {
    _is.OrderByBuilder<SaleTable>? orderBy,
    _is.OrderByListBuilder<SaleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Sale>(
      rows,
      orderBy: orderBy?.call(Sale.t),
      orderByList: orderByList?.call(Sale.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Sale].
  Future<Sale> deleteRow(
    _is.DatabaseSession session,
    Sale row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Sale>(
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
  Future<List<Sale>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SaleTable> where,
    _is.OrderByBuilder<SaleTable>? orderBy,
    _is.OrderByListBuilder<SaleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Sale>(
      where: where(Sale.t),
      orderBy: orderBy?.call(Sale.t),
      orderByList: orderByList?.call(Sale.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SaleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Sale>(
      where: where?.call(Sale.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Sale] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SaleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Sale>(
      where: where(Sale.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
