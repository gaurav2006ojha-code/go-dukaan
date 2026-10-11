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
import 'dart:async' as _ida;
import 'package:go_dukaan_client/src/protocol/customer.dart' as _ii3lug3f;
import 'package:go_dukaan_client/src/protocol/greetings/greeting.dart'
    as _iwsh7pzb;
import 'package:go_dukaan_client/src/protocol/monthly_report.dart' as _iytyfmv4;
import 'package:go_dukaan_client/src/protocol/product.dart' as _iwvdtx0k;
import 'package:go_dukaan_client/src/protocol/purchase.dart' as _ipzypbse;
import 'package:go_dukaan_client/src/protocol/purchase_item.dart' as _iy8is9l2;
import 'package:go_dukaan_client/src/protocol/sale.dart' as _i70qw4tc;
import 'package:go_dukaan_client/src/protocol/sale_item.dart' as _itcuuu4e;
import 'package:go_dukaan_client/src/protocol/shop.dart' as _ig5kabae;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// {@category Endpoint}
class EndpointCustomer extends _isc.EndpointRef {
  EndpointCustomer(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customer';

  _ida.Future<List<_ii3lug3f.Customer>> getCustomers() =>
      caller.callServerEndpoint<List<_ii3lug3f.Customer>>(
        'customer',
        'getCustomers',
        {},
      );

  _ida.Future<_ii3lug3f.Customer?> getCustomer(int customerId) =>
      caller.callServerEndpoint<_ii3lug3f.Customer?>(
        'customer',
        'getCustomer',
        {'customerId': customerId},
      );

  _ida.Future<_ii3lug3f.Customer> createCustomer({
    required String name,
    String? mobile,
    String? email,
    String? address,
  }) => caller.callServerEndpoint<_ii3lug3f.Customer>(
    'customer',
    'createCustomer',
    {
      'name': name,
      'mobile': mobile,
      'email': email,
      'address': address,
    },
  );

  _ida.Future<_ii3lug3f.Customer> updateCustomer({
    required int customerId,
    required String name,
    String? mobile,
    String? email,
    String? address,
  }) => caller.callServerEndpoint<_ii3lug3f.Customer>(
    'customer',
    'updateCustomer',
    {
      'customerId': customerId,
      'name': name,
      'mobile': mobile,
      'email': email,
      'address': address,
    },
  );

  _ida.Future<void> deleteCustomer(int customerId) =>
      caller.callServerEndpoint<void>(
        'customer',
        'deleteCustomer',
        {'customerId': customerId},
      );

  _ida.Future<List<_ii3lug3f.Customer>> searchCustomers(String query) =>
      caller.callServerEndpoint<List<_ii3lug3f.Customer>>(
        'customer',
        'searchCustomers',
        {'query': query},
      );
}

/// {@category Endpoint}
class EndpointProduct extends _isc.EndpointRef {
  EndpointProduct(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'product';

  _ida.Future<List<_iwvdtx0k.Product>> getProducts() =>
      caller.callServerEndpoint<List<_iwvdtx0k.Product>>(
        'product',
        'getProducts',
        {},
      );

  _ida.Future<_iwvdtx0k.Product> createProduct({
    required String name,
    String? sku,
    String? barcode,
    required String category,
    required double purchasePrice,
    required double sellingPrice,
    required int stockQuantity,
    required int lowStockAlert,
    required String unit,
  }) => caller.callServerEndpoint<_iwvdtx0k.Product>(
    'product',
    'createProduct',
    {
      'name': name,
      'sku': sku,
      'barcode': barcode,
      'category': category,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'stockQuantity': stockQuantity,
      'lowStockAlert': lowStockAlert,
      'unit': unit,
    },
  );

  _ida.Future<_iwvdtx0k.Product> updateProduct({
    required int productId,
    required String name,
    String? sku,
    String? barcode,
    required String category,
    required double purchasePrice,
    required double sellingPrice,
    required int stockQuantity,
    required int lowStockAlert,
    required String unit,
  }) => caller.callServerEndpoint<_iwvdtx0k.Product>(
    'product',
    'updateProduct',
    {
      'productId': productId,
      'name': name,
      'sku': sku,
      'barcode': barcode,
      'category': category,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'stockQuantity': stockQuantity,
      'lowStockAlert': lowStockAlert,
      'unit': unit,
    },
  );

  _ida.Future<void> deleteProduct(int productId) =>
      caller.callServerEndpoint<void>(
        'product',
        'deleteProduct',
        {'productId': productId},
      );

  _ida.Future<List<_iwvdtx0k.Product>> getLowStockProducts() =>
      caller.callServerEndpoint<List<_iwvdtx0k.Product>>(
        'product',
        'getLowStockProducts',
        {},
      );
}

/// {@category Endpoint}
class EndpointPurchase extends _isc.EndpointRef {
  EndpointPurchase(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'purchase';

  _ida.Future<int> createPurchase({
    required String supplierName,
    String? supplierPhone,
    required String invoiceNumber,
    required double paidAmount,
    String? notes,
    required DateTime purchasedAt,
    required List<Map<String, dynamic>> items,
  }) => caller.callServerEndpoint<int>(
    'purchase',
    'createPurchase',
    {
      'supplierName': supplierName,
      'supplierPhone': supplierPhone,
      'invoiceNumber': invoiceNumber,
      'paidAmount': paidAmount,
      'notes': notes,
      'purchasedAt': purchasedAt,
      'items': items,
    },
  );

  _ida.Future<List<_ipzypbse.Purchase>> getPurchases() =>
      caller.callServerEndpoint<List<_ipzypbse.Purchase>>(
        'purchase',
        'getPurchases',
        {},
      );

  _ida.Future<List<_iy8is9l2.PurchaseItem>> getPurchaseItems(int purchaseId) =>
      caller.callServerEndpoint<List<_iy8is9l2.PurchaseItem>>(
        'purchase',
        'getPurchaseItems',
        {'purchaseId': purchaseId},
      );
}

/// {@category Endpoint}
class EndpointReport extends _isc.EndpointRef {
  EndpointReport(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'report';

  _ida.Future<_iytyfmv4.MonthlyReport> getMonthlyReport(DateTime month) =>
      caller.callServerEndpoint<_iytyfmv4.MonthlyReport>(
        'report',
        'getMonthlyReport',
        {'month': month},
      );
}

/// {@category Endpoint}
class EndpointSale extends _isc.EndpointRef {
  EndpointSale(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'sale';

  _ida.Future<List<_i70qw4tc.Sale>> getSales() =>
      caller.callServerEndpoint<List<_i70qw4tc.Sale>>(
        'sale',
        'getSales',
        {},
      );

  _ida.Future<_i70qw4tc.Sale?> getSale(int saleId) =>
      caller.callServerEndpoint<_i70qw4tc.Sale?>(
        'sale',
        'getSale',
        {'saleId': saleId},
      );

  _ida.Future<List<_itcuuu4e.SaleItem>> getSaleItems(int saleId) =>
      caller.callServerEndpoint<List<_itcuuu4e.SaleItem>>(
        'sale',
        'getSaleItems',
        {'saleId': saleId},
      );

  _ida.Future<_i70qw4tc.Sale> createSale({
    int? customerId,
    required List<int> productIds,
    required List<int> quantities,
    required double discountAmount,
    required double taxPercent,
    required String paymentMethod,
    required double paidAmount,
    String? notes,
  }) => caller.callServerEndpoint<_i70qw4tc.Sale>(
    'sale',
    'createSale',
    {
      'customerId': customerId,
      'productIds': productIds,
      'quantities': quantities,
      'discountAmount': discountAmount,
      'taxPercent': taxPercent,
      'paymentMethod': paymentMethod,
      'paidAmount': paidAmount,
      'notes': notes,
    },
  );
}

/// {@category Endpoint}
class EndpointShop extends _isc.EndpointRef {
  EndpointShop(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'shop';

  /// Current logged-in user's shop
  _ida.Future<_ig5kabae.Shop?> getMyShop() =>
      caller.callServerEndpoint<_ig5kabae.Shop?>(
        'shop',
        'getMyShop',
        {},
      );

  /// Create or update current user's shop
  _ida.Future<_ig5kabae.Shop> saveShop({
    required String shopName,
    required String ownerName,
    required String businessType,
    required String mobile,
    required String city,
  }) => caller.callServerEndpoint<_ig5kabae.Shop>(
    'shop',
    'saveShop',
    {
      'shopName': shopName,
      'ownerName': ownerName,
      'businessType': businessType,
      'mobile': mobile,
      'city': city,
    },
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_iwsh7pzb.Greeting> hello(String name) =>
      caller.callServerEndpoint<_iwsh7pzb.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    customer = EndpointCustomer(this);
    product = EndpointProduct(this);
    purchase = EndpointPurchase(this);
    report = EndpointReport(this);
    sale = EndpointSale(this);
    shop = EndpointShop(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointCustomer customer;

  late final EndpointProduct product;

  late final EndpointPurchase purchase;

  late final EndpointReport report;

  late final EndpointSale sale;

  late final EndpointShop shop;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'customer': customer,
    'product': product,
    'purchase': purchase,
    'report': report,
    'sale': sale,
    'shop': shop,
    'greeting': greeting,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
