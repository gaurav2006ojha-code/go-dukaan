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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/customer_endpoint.dart' as _irj2k3gq;
import '../endpoints/product_endpoint.dart' as _im5j1753;
import '../endpoints/purchase_endpoint.dart' as _ixg2gexe;
import '../endpoints/report_endpoint.dart' as _i90z2r7i;
import '../endpoints/sale_endpoint.dart' as _ihn4r5xn;
import '../endpoints/shop_endpoint.dart' as _i4fqeydl;
import '../greetings/greeting_endpoint.dart' as _il624ik7;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'customer': _irj2k3gq.CustomerEndpoint()
        ..initialize(
          server,
          'customer',
          null,
        ),
      'product': _im5j1753.ProductEndpoint()
        ..initialize(
          server,
          'product',
          null,
        ),
      'purchase': _ixg2gexe.PurchaseEndpoint()
        ..initialize(
          server,
          'purchase',
          null,
        ),
      'report': _i90z2r7i.ReportEndpoint()
        ..initialize(
          server,
          'report',
          null,
        ),
      'sale': _ihn4r5xn.SaleEndpoint()
        ..initialize(
          server,
          'sale',
          null,
        ),
      'shop': _i4fqeydl.ShopEndpoint()
        ..initialize(
          server,
          'shop',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['customer'] = _is.EndpointConnector(
      name: 'customer',
      endpoint: endpoints['customer']!,
      methodConnectors: {
        'getCustomers': _is.MethodConnector(
          name: 'getCustomers',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _irj2k3gq.CustomerEndpoint)
                  .getCustomers(session),
        ),
        'getCustomer': _is.MethodConnector(
          name: 'getCustomer',
          params: {
            'customerId': _is.ParameterDescription(
              name: 'customerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _irj2k3gq.CustomerEndpoint)
                  .getCustomer(
                    session,
                    params['customerId'],
                  ),
        ),
        'createCustomer': _is.MethodConnector(
          name: 'createCustomer',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'mobile': _is.ParameterDescription(
              name: 'mobile',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'address': _is.ParameterDescription(
              name: 'address',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _irj2k3gq.CustomerEndpoint)
                  .createCustomer(
                    session,
                    name: params['name'],
                    mobile: params['mobile'],
                    email: params['email'],
                    address: params['address'],
                  ),
        ),
        'updateCustomer': _is.MethodConnector(
          name: 'updateCustomer',
          params: {
            'customerId': _is.ParameterDescription(
              name: 'customerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'mobile': _is.ParameterDescription(
              name: 'mobile',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'address': _is.ParameterDescription(
              name: 'address',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _irj2k3gq.CustomerEndpoint)
                  .updateCustomer(
                    session,
                    customerId: params['customerId'],
                    name: params['name'],
                    mobile: params['mobile'],
                    email: params['email'],
                    address: params['address'],
                  ),
        ),
        'deleteCustomer': _is.MethodConnector(
          name: 'deleteCustomer',
          params: {
            'customerId': _is.ParameterDescription(
              name: 'customerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _irj2k3gq.CustomerEndpoint)
                  .deleteCustomer(
                    session,
                    params['customerId'],
                  ),
        ),
        'searchCustomers': _is.MethodConnector(
          name: 'searchCustomers',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _irj2k3gq.CustomerEndpoint)
                  .searchCustomers(
                    session,
                    params['query'],
                  ),
        ),
      },
    );
    connectors['product'] = _is.EndpointConnector(
      name: 'product',
      endpoint: endpoints['product']!,
      methodConnectors: {
        'getProducts': _is.MethodConnector(
          name: 'getProducts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .getProducts(session),
        ),
        'createProduct': _is.MethodConnector(
          name: 'createProduct',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'sku': _is.ParameterDescription(
              name: 'sku',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'barcode': _is.ParameterDescription(
              name: 'barcode',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'purchasePrice': _is.ParameterDescription(
              name: 'purchasePrice',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'sellingPrice': _is.ParameterDescription(
              name: 'sellingPrice',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'stockQuantity': _is.ParameterDescription(
              name: 'stockQuantity',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'lowStockAlert': _is.ParameterDescription(
              name: 'lowStockAlert',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'unit': _is.ParameterDescription(
              name: 'unit',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .createProduct(
                    session,
                    name: params['name'],
                    sku: params['sku'],
                    barcode: params['barcode'],
                    category: params['category'],
                    purchasePrice: params['purchasePrice'],
                    sellingPrice: params['sellingPrice'],
                    stockQuantity: params['stockQuantity'],
                    lowStockAlert: params['lowStockAlert'],
                    unit: params['unit'],
                  ),
        ),
        'updateProduct': _is.MethodConnector(
          name: 'updateProduct',
          params: {
            'productId': _is.ParameterDescription(
              name: 'productId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'sku': _is.ParameterDescription(
              name: 'sku',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'barcode': _is.ParameterDescription(
              name: 'barcode',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'purchasePrice': _is.ParameterDescription(
              name: 'purchasePrice',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'sellingPrice': _is.ParameterDescription(
              name: 'sellingPrice',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'stockQuantity': _is.ParameterDescription(
              name: 'stockQuantity',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'lowStockAlert': _is.ParameterDescription(
              name: 'lowStockAlert',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'unit': _is.ParameterDescription(
              name: 'unit',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .updateProduct(
                    session,
                    productId: params['productId'],
                    name: params['name'],
                    sku: params['sku'],
                    barcode: params['barcode'],
                    category: params['category'],
                    purchasePrice: params['purchasePrice'],
                    sellingPrice: params['sellingPrice'],
                    stockQuantity: params['stockQuantity'],
                    lowStockAlert: params['lowStockAlert'],
                    unit: params['unit'],
                  ),
        ),
        'deleteProduct': _is.MethodConnector(
          name: 'deleteProduct',
          params: {
            'productId': _is.ParameterDescription(
              name: 'productId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .deleteProduct(
                    session,
                    params['productId'],
                  ),
        ),
        'getLowStockProducts': _is.MethodConnector(
          name: 'getLowStockProducts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .getLowStockProducts(session),
        ),
      },
    );
    connectors['purchase'] = _is.EndpointConnector(
      name: 'purchase',
      endpoint: endpoints['purchase']!,
      methodConnectors: {
        'createPurchase': _is.MethodConnector(
          name: 'createPurchase',
          params: {
            'supplierName': _is.ParameterDescription(
              name: 'supplierName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'supplierPhone': _is.ParameterDescription(
              name: 'supplierPhone',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'invoiceNumber': _is.ParameterDescription(
              name: 'invoiceNumber',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'paidAmount': _is.ParameterDescription(
              name: 'paidAmount',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'purchasedAt': _is.ParameterDescription(
              name: 'purchasedAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'items': _is.ParameterDescription(
              name: 'items',
              type: _is.getType<List<Map<String, dynamic>>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['purchase'] as _ixg2gexe.PurchaseEndpoint)
                  .createPurchase(
                    session,
                    supplierName: params['supplierName'],
                    supplierPhone: params['supplierPhone'],
                    invoiceNumber: params['invoiceNumber'],
                    paidAmount: params['paidAmount'],
                    notes: params['notes'],
                    purchasedAt: params['purchasedAt'],
                    items: params['items'],
                  ),
        ),
        'getPurchases': _is.MethodConnector(
          name: 'getPurchases',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['purchase'] as _ixg2gexe.PurchaseEndpoint)
                  .getPurchases(session),
        ),
        'getPurchaseItems': _is.MethodConnector(
          name: 'getPurchaseItems',
          params: {
            'purchaseId': _is.ParameterDescription(
              name: 'purchaseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['purchase'] as _ixg2gexe.PurchaseEndpoint)
                  .getPurchaseItems(
                    session,
                    params['purchaseId'],
                  ),
        ),
      },
    );
    connectors['report'] = _is.EndpointConnector(
      name: 'report',
      endpoint: endpoints['report']!,
      methodConnectors: {
        'getMonthlyReport': _is.MethodConnector(
          name: 'getMonthlyReport',
          params: {
            'month': _is.ParameterDescription(
              name: 'month',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i90z2r7i.ReportEndpoint)
                  .getMonthlyReport(
                    session,
                    params['month'],
                  ),
        ),
      },
    );
    connectors['sale'] = _is.EndpointConnector(
      name: 'sale',
      endpoint: endpoints['sale']!,
      methodConnectors: {
        'getSales': _is.MethodConnector(
          name: 'getSales',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sale'] as _ihn4r5xn.SaleEndpoint).getSales(
                session,
              ),
        ),
        'getSale': _is.MethodConnector(
          name: 'getSale',
          params: {
            'saleId': _is.ParameterDescription(
              name: 'saleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['sale'] as _ihn4r5xn.SaleEndpoint).getSale(
                session,
                params['saleId'],
              ),
        ),
        'getSaleItems': _is.MethodConnector(
          name: 'getSaleItems',
          params: {
            'saleId': _is.ParameterDescription(
              name: 'saleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['sale'] as _ihn4r5xn.SaleEndpoint).getSaleItems(
                    session,
                    params['saleId'],
                  ),
        ),
        'createSale': _is.MethodConnector(
          name: 'createSale',
          params: {
            'customerId': _is.ParameterDescription(
              name: 'customerId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'productIds': _is.ParameterDescription(
              name: 'productIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
            'quantities': _is.ParameterDescription(
              name: 'quantities',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
            'discountAmount': _is.ParameterDescription(
              name: 'discountAmount',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'taxPercent': _is.ParameterDescription(
              name: 'taxPercent',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'paymentMethod': _is.ParameterDescription(
              name: 'paymentMethod',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'paidAmount': _is.ParameterDescription(
              name: 'paidAmount',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['sale'] as _ihn4r5xn.SaleEndpoint).createSale(
                    session,
                    customerId: params['customerId'],
                    productIds: params['productIds'],
                    quantities: params['quantities'],
                    discountAmount: params['discountAmount'],
                    taxPercent: params['taxPercent'],
                    paymentMethod: params['paymentMethod'],
                    paidAmount: params['paidAmount'],
                    notes: params['notes'],
                  ),
        ),
      },
    );
    connectors['shop'] = _is.EndpointConnector(
      name: 'shop',
      endpoint: endpoints['shop']!,
      methodConnectors: {
        'getMyShop': _is.MethodConnector(
          name: 'getMyShop',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['shop'] as _i4fqeydl.ShopEndpoint)
                  .getMyShop(session),
        ),
        'saveShop': _is.MethodConnector(
          name: 'saveShop',
          params: {
            'shopName': _is.ParameterDescription(
              name: 'shopName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'ownerName': _is.ParameterDescription(
              name: 'ownerName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'businessType': _is.ParameterDescription(
              name: 'businessType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'mobile': _is.ParameterDescription(
              name: 'mobile',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'city': _is.ParameterDescription(
              name: 'city',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['shop'] as _i4fqeydl.ShopEndpoint).saveShop(
                session,
                shopName: params['shopName'],
                ownerName: params['ownerName'],
                businessType: params['businessType'],
                mobile: params['mobile'],
                city: params['city'],
              ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
