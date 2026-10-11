/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:go_dukaan_client/src/protocol/customer.dart' as _ii3lug3f;
import 'package:go_dukaan_client/src/protocol/product.dart' as _iwvdtx0k;
import 'package:go_dukaan_client/src/protocol/purchase.dart' as _ipzypbse;
import 'package:go_dukaan_client/src/protocol/purchase_item.dart' as _iy8is9l2;
import 'package:go_dukaan_client/src/protocol/sale.dart' as _i70qw4tc;
import 'package:go_dukaan_client/src/protocol/sale_item.dart' as _itcuuu4e;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'customer.dart' as _id4xn1l3;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'monthly_report.dart' as _iw4jhmim;
import 'product.dart' as _i8ctgxfn;
import 'purchase.dart' as _i02kqqky;
import 'purchase_item.dart' as _ixhgnuco;
import 'sale.dart' as _i71glfzd;
import 'sale_item.dart' as _ict8yfwl;
import 'shop.dart' as _isgf2ncs;
export 'customer.dart';
export 'greetings/greeting.dart';
export 'monthly_report.dart';
export 'product.dart';
export 'purchase.dart';
export 'purchase_item.dart';
export 'sale.dart';
export 'sale_item.dart';
export 'shop.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _id4xn1l3.Customer) {
      return _id4xn1l3.Customer.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _iw4jhmim.MonthlyReport) {
      return _iw4jhmim.MonthlyReport.fromJson(data) as T;
    }
    if (t == _i8ctgxfn.Product) {
      return _i8ctgxfn.Product.fromJson(data) as T;
    }
    if (t == _i02kqqky.Purchase) {
      return _i02kqqky.Purchase.fromJson(data) as T;
    }
    if (t == _ixhgnuco.PurchaseItem) {
      return _ixhgnuco.PurchaseItem.fromJson(data) as T;
    }
    if (t == _i71glfzd.Sale) {
      return _i71glfzd.Sale.fromJson(data) as T;
    }
    if (t == _ict8yfwl.SaleItem) {
      return _ict8yfwl.SaleItem.fromJson(data) as T;
    }
    if (t == _isgf2ncs.Shop) {
      return _isgf2ncs.Shop.fromJson(data) as T;
    }
    if (t == _isc.getType<_id4xn1l3.Customer?>()) {
      return (data != null ? _id4xn1l3.Customer.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iw4jhmim.MonthlyReport?>()) {
      return (data != null ? _iw4jhmim.MonthlyReport.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i8ctgxfn.Product?>()) {
      return (data != null ? _i8ctgxfn.Product.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i02kqqky.Purchase?>()) {
      return (data != null ? _i02kqqky.Purchase.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixhgnuco.PurchaseItem?>()) {
      return (data != null ? _ixhgnuco.PurchaseItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i71glfzd.Sale?>()) {
      return (data != null ? _i71glfzd.Sale.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ict8yfwl.SaleItem?>()) {
      return (data != null ? _ict8yfwl.SaleItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isgf2ncs.Shop?>()) {
      return (data != null ? _isgf2ncs.Shop.fromJson(data) : null) as T;
    }
    if (t == List<_ii3lug3f.Customer>) {
      return (data as List)
              .map((e) => deserialize<_ii3lug3f.Customer>(e))
              .toList()
          as T;
    }
    if (t == List<_iwvdtx0k.Product>) {
      return (data as List)
              .map((e) => deserialize<_iwvdtx0k.Product>(e))
              .toList()
          as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, dynamic>>(e))
              .toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == dynamic) {
      return deserializeDynamicFieldValue(data) as T;
    }
    if (t == List<_ipzypbse.Purchase>) {
      return (data as List)
              .map((e) => deserialize<_ipzypbse.Purchase>(e))
              .toList()
          as T;
    }
    if (t == List<_iy8is9l2.PurchaseItem>) {
      return (data as List)
              .map((e) => deserialize<_iy8is9l2.PurchaseItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i70qw4tc.Sale>) {
      return (data as List).map((e) => deserialize<_i70qw4tc.Sale>(e)).toList()
          as T;
    }
    if (t == List<_itcuuu4e.SaleItem>) {
      return (data as List)
              .map((e) => deserialize<_itcuuu4e.SaleItem>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _id4xn1l3.Customer => 'Customer',
      _izw8z7ou.Greeting => 'Greeting',
      _iw4jhmim.MonthlyReport => 'MonthlyReport',
      _i8ctgxfn.Product => 'Product',
      _i02kqqky.Purchase => 'Purchase',
      _ixhgnuco.PurchaseItem => 'PurchaseItem',
      _i71glfzd.Sale => 'Sale',
      _ict8yfwl.SaleItem => 'SaleItem',
      _isgf2ncs.Shop => 'Shop',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('go_dukaan.', '');
    }

    switch (data) {
      case _id4xn1l3.Customer():
        return 'Customer';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _iw4jhmim.MonthlyReport():
        return 'MonthlyReport';
      case _i8ctgxfn.Product():
        return 'Product';
      case _i02kqqky.Purchase():
        return 'Purchase';
      case _ixhgnuco.PurchaseItem():
        return 'PurchaseItem';
      case _i71glfzd.Sale():
        return 'Sale';
      case _ict8yfwl.SaleItem():
        return 'SaleItem';
      case _isgf2ncs.Shop():
        return 'Shop';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_id4xn1l3.Customer>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'MonthlyReport') {
      return deserialize<_iw4jhmim.MonthlyReport>(data['data']);
    }
    if (dataClassName == 'Product') {
      return deserialize<_i8ctgxfn.Product>(data['data']);
    }
    if (dataClassName == 'Purchase') {
      return deserialize<_i02kqqky.Purchase>(data['data']);
    }
    if (dataClassName == 'PurchaseItem') {
      return deserialize<_ixhgnuco.PurchaseItem>(data['data']);
    }
    if (dataClassName == 'Sale') {
      return deserialize<_i71glfzd.Sale>(data['data']);
    }
    if (dataClassName == 'SaleItem') {
      return deserialize<_ict8yfwl.SaleItem>(data['data']);
    }
    if (dataClassName == 'Shop') {
      return deserialize<_isgf2ncs.Shop>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('go_dukaan', this);
    _iacc.Protocol().registerHostProtocol('go_dukaan', this);
  }

  @override
  String getModuleName() => 'go_dukaan';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
