import 'dart:math' as math;



import 'package:flutter/material.dart';

import 'screens/inventory_screen.dart';
import 'screens/customer_screen.dart';
import 'screens/billing_screen.dart';
import 'screens/purchase_screen.dart';
import 'screens/reports_screen.dart';


import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';



import 'client.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();



  await initializeClient();



  runApp(const GoDukaanApp());

}



class GoDukaanApp extends StatelessWidget {

  const GoDukaanApp({super.key});



  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'GO Dukaan',

      theme: ThemeData(

        useMaterial3: true,

        brightness: Brightness.dark,

        scaffoldBackgroundColor: const Color(0xFF08111F),

      ),

      home: const GoDukaanRoot(),

    );

  }

}



class GoDukaanRoot extends StatefulWidget {
  const GoDukaanRoot({super.key});

  @override
  State<GoDukaanRoot> createState() => _GoDukaanRootState();
}

class _GoDukaanRootState extends State<GoDukaanRoot> {
  Future<Map<String, String>?>? _shopFuture;

  @override
  void initState() {
    super.initState();

    client.auth.authInfoListenable.addListener(_onAuthChanged);

    if (client.auth.isAuthenticated) {
      _shopFuture = _loadShop();
    }
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    if (!mounted) return;

    if (client.auth.isAuthenticated) {
      setState(() {
        _shopFuture = _loadShop();
      });
    } else {
      setState(() {
        _shopFuture = null;
      });
    }
  }

  Future<Map<String, String>?> _loadShop() async {
    final shop = await client.shop.getMyShop();

    if (shop == null) {
      return null;
    }

    return {
      'shopName': shop.shopName,
      'ownerName': shop.ownerName,
      'businessType': shop.businessType,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (!client.auth.isAuthenticated) {
      return const AuthScreen();
    }

    return FutureBuilder<Map<String, String>?>(
      future: _shopFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _RootLoadingScreen(
            message: 'Loading your shop...',
          );
        }

        if (snapshot.hasError) {
          return _RootErrorScreen(
            onRetry: () {
              setState(() {
                _shopFuture = _loadShop();
              });
            },
          );
        }

        final shop = snapshot.data;

        // Logged in but no shop exists yet.
        // This is a NEW account, so show Shop Setup.
        if (shop == null) {
          return const ShopSetupScreen();
        }

        // Logged in and shop already exists.
        // Go directly to Dashboard.
        return DashboardScreen(
          shopName: shop['shopName']!,
          ownerName: shop['ownerName']!,
          businessType: shop['businessType']!,
        );
      },
    );
  }
}

class _RootLoadingScreen extends StatelessWidget {
  final String message;

  const _RootLoadingScreen({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07111F),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF19B5FE),
                    Color(0xFF6557FF),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF19B5FE)
                        .withValues(alpha: 0.20),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: const Icon(
                Icons.storefront_rounded,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 22),
            const CircularProgressIndicator(
              color: Color(0xFF19B5FE),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RootErrorScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const _RootErrorScreen({
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07111F),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 460,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.055),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cloud_off_rounded,
                    size: 48,
                    color: Color(0xFF19B5FE),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Unable to load your shop',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please check that the Serverpod server is running and try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: Colors.white.withValues(alpha: 0.50),
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text(
                        'Try Again',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF19B5FE),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class AuthScreen extends StatelessWidget {

  const AuthScreen({super.key});



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          const _GradientBackground(),



          SafeArea(

            child: Center(

              child: SingleChildScrollView(

                padding: const EdgeInsets.all(20),

                child: ConstrainedBox(

                  constraints: const BoxConstraints(

                    maxWidth: 520,

                  ),

                  child: Column(

                    children: [

                      const SizedBox(height: 30),



                      const _GoDukaanLogo(),



                      const SizedBox(height: 22),



                      const Text(

                        'Welcome to GO Dukaan',

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: 30,

                          fontWeight: FontWeight.w800,

                        ),

                      ),



                      const SizedBox(height: 8),



                      Text(

                        'Login or create your shop account',

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: 14,

                          color: Colors.white.withValues(alpha: 0.55),

                        ),

                      ),



                      const SizedBox(height: 30),



                      Container(

                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(

                          color: Colors.white.withValues(alpha: 0.055),

                          borderRadius: BorderRadius.circular(25),

                          border: Border.all(

                            color: Colors.white.withValues(alpha: 0.08),

                          ),

                        ),

                        child: SignInWidget(

                          client: client,

                          onAuthenticated: () {

                            // Authentication state is handled by GoDukaanRoot.

                          },

                          onError: (error) {

                            ScaffoldMessenger.of(context).showSnackBar(

                              SnackBar(

                                content: Text(

                                  'Authentication error: $error',

                                ),

                                behavior: SnackBarBehavior.floating,

                              ),

                            );

                          },

                        ),

                      ),



                      const SizedBox(height: 25),



                      Text(

                        'Your account keeps your shop data secure.',

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: 12,

                          color: Colors.white.withValues(alpha: 0.35),

                        ),

                      ),

                    ],

                  ),

                ),

              ),

            ),

          ),

        ],

      ),

    );

  }

}





// ============================================================

// WELCOME SCREEN

// ============================================================



class WelcomeScreen extends StatefulWidget {

  const WelcomeScreen({super.key});



  @override

  State<WelcomeScreen> createState() => _WelcomeScreenState();

}



class _WelcomeScreenState extends State<WelcomeScreen>

    with TickerProviderStateMixin {

  late AnimationController _backgroundController;

  late AnimationController _contentController;



  late Animation<double> _backgroundAnimation;

  late Animation<double> _fadeAnimation;

  late Animation<Offset> _slideAnimation;



  @override

  void initState() {

    super.initState();



    _backgroundController = AnimationController(

      vsync: this,

      duration: const Duration(seconds: 5),

    )..repeat();



    _backgroundAnimation = Tween<double>(

      begin: 0,

      end: math.pi * 2,

    ).animate(_backgroundController);



    _contentController = AnimationController(

      vsync: this,

      duration: const Duration(milliseconds: 1000),

    );



    _fadeAnimation = CurvedAnimation(

      parent: _contentController,

      curve: Curves.easeOut,

    );



    _slideAnimation = Tween<Offset>(

      begin: const Offset(0, 0.12),

      end: Offset.zero,

    ).animate(

      CurvedAnimation(

        parent: _contentController,

        curve: Curves.easeOutCubic,

      ),

    );



    _contentController.forward();

  }



  @override

  void dispose() {

    _backgroundController.dispose();

    _contentController.dispose();

    super.dispose();

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          const _GradientBackground(),



          AnimatedBuilder(

            animation: _backgroundAnimation,

            builder: (context, child) {

              final value = _backgroundAnimation.value;



              return Stack(

                children: [

                  Positioned(

                    top: -100 + math.sin(value) * 25,

                    right: -80 + math.cos(value) * 20,

                    child: _glowCircle(

                      260,

                      const Color(0xFF00C6FF),

                    ),

                  ),

                  Positioned(

                    bottom: -120 + math.cos(value) * 30,

                    left: -100 + math.sin(value) * 20,

                    child: _glowCircle(

                      300,

                      const Color(0xFF7C4DFF),

                    ),

                  ),

                ],

              );

            },

          ),



          SafeArea(

            child: Center(

              child: SingleChildScrollView(

                padding: const EdgeInsets.symmetric(

                  horizontal: 24,

                  vertical: 30,

                ),

                child: ConstrainedBox(

                  constraints: const BoxConstraints(

                    maxWidth: 520,

                  ),

                  child: FadeTransition(

                    opacity: _fadeAnimation,

                    child: SlideTransition(

                      position: _slideAnimation,

                      child: Column(

                        children: [

                          const SizedBox(height: 20),



                          const _GoDukaanLogo(),



                          const SizedBox(height: 28),



                          const Text(

                            'GO Dukaan',

                            style: TextStyle(

                              fontSize: 38,

                              fontWeight: FontWeight.w800,

                              letterSpacing: -1.2,

                            ),

                          ),



                          const SizedBox(height: 10),



                          Text(

                            'Your shop. Your business.nAll in one place.',

                            textAlign: TextAlign.center,

                            style: TextStyle(

                              fontSize: 17,

                              height: 1.5,

                              color: Colors.white.withValues(alpha: 0.68),

                            ),

                          ),



                          const SizedBox(height: 38),



                          _buildFeatures(),



                          const SizedBox(height: 30),



                          SizedBox(

                            width: double.infinity,

                            height: 58,

                            child: ElevatedButton(

                              onPressed: () {

                                Navigator.push(

                                  context,

                                  _createRoute(

                                    const ShopSetupScreen(),

                                  ),

                                );

                              },

                              style: ElevatedButton.styleFrom(

                                backgroundColor:

                                    const Color(0xFF19B5FE),

                                foregroundColor: Colors.white,

                                elevation: 0,

                                shape: RoundedRectangleBorder(

                                  borderRadius:

                                      BorderRadius.circular(18),

                                ),

                              ),

                              child: const Row(

                                mainAxisAlignment:

                                    MainAxisAlignment.center,

                                children: [

                                  Text(

                                    'Get Started',

                                    style: TextStyle(

                                      fontSize: 17,

                                      fontWeight: FontWeight.w700,

                                    ),

                                  ),

                                  SizedBox(width: 10),

                                  Icon(

                                    Icons.arrow_forward_rounded,

                                  ),

                                ],

                              ),

                            ),

                          ),



                          const SizedBox(height: 14),



                          SizedBox(

                            width: double.infinity,

                            height: 56,

                            child: OutlinedButton(

                              onPressed: () {},

                              style: OutlinedButton.styleFrom(

                                foregroundColor: Colors.white,

                                side: BorderSide(

                                  color: Colors.white.withValues(alpha: 0.18),

                                ),

                                shape: RoundedRectangleBorder(

                                  borderRadius:

                                      BorderRadius.circular(18),

                                ),

                              ),

                              child: const Text(

                                'I already have an account',

                                style: TextStyle(

                                  fontSize: 15,

                                  fontWeight: FontWeight.w600,

                                ),

                              ),

                            ),

                          ),



                          const SizedBox(height: 28),



                          Text(

                            'Billing • Inventory • Khata • Reports',

                            style: TextStyle(

                              fontSize: 12,

                              letterSpacing: 0.5,

                              color: Colors.white.withValues(alpha: 0.42),

                            ),

                          ),

                        ],

                      ),

                    ),

                  ),

                ),

              ),

            ),

          ),

        ],

      ),

    );

  }



  Widget _buildFeatures() {

    return Container(

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white.withValues(alpha: 0.055),

        borderRadius: BorderRadius.circular(24),

        border: Border.all(

          color: Colors.white.withValues(alpha: 0.09),

        ),

      ),

      child: const Column(

        children: [

          _FeatureRow(

            icon: Icons.point_of_sale_rounded,

            title: 'Smart Billing',

            subtitle: 'Create bills quickly',

          ),

          SizedBox(height: 18),

          _FeatureRow(

            icon: Icons.inventory_2_rounded,

            title: 'Inventory',

            subtitle: 'Know your stock anytime',

          ),

          SizedBox(height: 18),

          _FeatureRow(

            icon: Icons.account_balance_wallet_rounded,

            title: 'Customer Khata',

            subtitle: 'Keep payments organized',

          ),

        ],

      ),

    );

  }



  Widget _glowCircle(double size, Color color) {

    return Container(

      width: size,

      height: size,

      decoration: BoxDecoration(

        shape: BoxShape.circle,

        color: color.withValues(alpha: 0.055),

        boxShadow: [

          BoxShadow(

            color: color.withValues(alpha: 0.10),

            blurRadius: 100,

            spreadRadius: 30,

          ),

        ],

      ),

    );

  }

}



// ============================================================

// SHOP SETUP SCREEN

// ============================================================



class ShopSetupScreen extends StatefulWidget {

  const ShopSetupScreen({super.key});



  @override

  State<ShopSetupScreen> createState() => _ShopSetupScreenState();

}



class _ShopSetupScreenState extends State<ShopSetupScreen>

    with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();



  final TextEditingController _shopNameController =

      TextEditingController();



  final TextEditingController _ownerNameController =

      TextEditingController();



  final TextEditingController _mobileController =

      TextEditingController();



  final TextEditingController _cityController =

      TextEditingController();



  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;

  late Animation<Offset> _slideAnimation;



  String _businessType = 'General Store';



  final List<String> _businessTypes = [

    'General Store',

    'Grocery Store',

    'Clothing Store',

    'Mobile Shop',

    'Stationery Shop',

    'Electronics Shop',

    'Other',

  ];



  @override

  void initState() {

    super.initState();



    _animationController = AnimationController(

      vsync: this,

      duration: const Duration(milliseconds: 900),

    );



    _fadeAnimation = CurvedAnimation(

      parent: _animationController,

      curve: Curves.easeOut,

    );



    _slideAnimation = Tween<Offset>(

      begin: const Offset(0, 0.08),

      end: Offset.zero,

    ).animate(

      CurvedAnimation(

        parent: _animationController,

        curve: Curves.easeOutCubic,

      ),

    );



    _animationController.forward();

  }



  @override

  void dispose() {

    _animationController.dispose();

    _shopNameController.dispose();

    _ownerNameController.dispose();

    _mobileController.dispose();

    _cityController.dispose();

    super.dispose();

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          const _GradientBackground(),



          SafeArea(

            child: Center(

              child: SingleChildScrollView(

                padding: const EdgeInsets.fromLTRB(

                  22,

                  18,

                  22,

                  35,

                ),

                child: ConstrainedBox(

                  constraints: const BoxConstraints(

                    maxWidth: 560,

                  ),

                  child: FadeTransition(

                    opacity: _fadeAnimation,

                    child: SlideTransition(

                      position: _slideAnimation,

                      child: Form(

                        key: _formKey,

                        child: Column(

                          crossAxisAlignment:

                              CrossAxisAlignment.start,

                          children: [

                            // Back button

                            IconButton(

                              onPressed: () {

                                Navigator.pop(context);

                              },

                              icon: const Icon(

                                Icons.arrow_back_rounded,

                              ),

                              style: IconButton.styleFrom(

                                backgroundColor:

                                    Colors.white.withValues(alpha: 0.07),

                              ),

                            ),



                            const SizedBox(height: 22),



                            // Header

                            Center(

                              child: Container(

                                width: 76,

                                height: 76,

                                decoration: BoxDecoration(

                                  borderRadius:

                                      BorderRadius.circular(23),

                                  gradient: const LinearGradient(

                                    colors: [

                                      Color(0xFF19B5FE),

                                      Color(0xFF6557FF),

                                    ],

                                  ),

                                  boxShadow: [

                                    BoxShadow(

                                      color: const Color(0xFF19B5FE)

                                          .withValues(alpha: 0.20),

                                      blurRadius: 30,

                                    ),

                                  ],

                                ),

                                child: const Icon(

                                  Icons.storefront_rounded,

                                  size: 40,

                                  color: Colors.white,

                                ),

                              ),

                            ),



                            const SizedBox(height: 24),



                            const Center(

                              child: Text(

                                'Set up your shop',

                                textAlign: TextAlign.center,

                                style: TextStyle(

                                  fontSize: 30,

                                  fontWeight: FontWeight.w800,

                                ),

                              ),

                            ),



                            const SizedBox(height: 8),



                            Center(

                              child: Text(

                                'Tell us a little about your business',

                                textAlign: TextAlign.center,

                                style: TextStyle(

                                  fontSize: 14,

                                  color: Colors.white

                                      .withValues(alpha: 0.55),

                                ),

                              ),

                            ),



                            const SizedBox(height: 34),



                            _sectionTitle(

                              'SHOP INFORMATION',

                              Icons.store_rounded,

                            ),



                            const SizedBox(height: 14),



                            _inputField(

                              controller: _shopNameController,

                              label: 'Shop Name',

                              hint: 'e.g. Gaurav General Store',

                              icon: Icons.storefront_outlined,

                            ),



                            const SizedBox(height: 16),



                            _inputField(

                              controller: _ownerNameController,

                              label: 'Owner Name',

                              hint: 'Enter your name',

                              icon: Icons.person_outline_rounded,

                            ),



                            const SizedBox(height: 16),



                            _businessDropdown(),



                            const SizedBox(height: 28),



                            _sectionTitle(

                              'CONTACT INFORMATION',

                              Icons.contact_phone_outlined,

                            ),



                            const SizedBox(height: 14),



                            _inputField(

                              controller: _mobileController,

                              label: 'Mobile Number',

                              hint: '10 digit mobile number',

                              icon: Icons.phone_outlined,

                              keyboardType: TextInputType.phone,

                              maxLength: 10,

                            ),



                            const SizedBox(height: 16),



                            _inputField(

                              controller: _cityController,

                              label: 'City',

                              hint: 'e.g. Patna',

                              icon: Icons.location_on_outlined,

                            ),



                            const SizedBox(height: 32),



                            SizedBox(

                              width: double.infinity,

                              height: 58,

                              child: ElevatedButton(

                                onPressed: _continueSetup,

                                style: ElevatedButton.styleFrom(

                                  backgroundColor:

                                      const Color(0xFF19B5FE),

                                  foregroundColor: Colors.white,

                                  elevation: 0,

                                  shape: RoundedRectangleBorder(

                                    borderRadius:

                                        BorderRadius.circular(18),

                                  ),

                                ),

                                child: const Row(

                                  mainAxisAlignment:

                                      MainAxisAlignment.center,

                                  children: [

                                    Text(

                                      'Continue',

                                      style: TextStyle(

                                        fontSize: 17,

                                        fontWeight: FontWeight.w700,

                                      ),

                                    ),

                                    SizedBox(width: 10),

                                    Icon(

                                      Icons.arrow_forward_rounded,

                                    ),

                                  ],

                                ),

                              ),

                            ),



                            const SizedBox(height: 18),



                            Center(

                              child: Text(

                                'You can change these details later',

                                style: TextStyle(

                                  fontSize: 12,

                                  color: Colors.white

                                      .withValues(alpha: 0.35),

                                ),

                              ),

                            ),

                          ],

                        ),

                      ),

                    ),

                  ),

                ),

              ),

            ),

          ),

        ],

      ),

    );

  }



  Widget _sectionTitle(String title, IconData icon) {

    return Row(

      children: [

        Icon(

          icon,

          size: 17,

          color: const Color(0xFF19B5FE),

        ),

        const SizedBox(width: 8),

        Text(

          title,

          style: TextStyle(

            fontSize: 11,

            fontWeight: FontWeight.w800,

            letterSpacing: 1.2,

            color: Colors.white.withValues(alpha: 0.55),

          ),

        ),

      ],

    );

  }



  Widget _inputField({

    required TextEditingController controller,

    required String label,

    required String hint,

    required IconData icon,

    TextInputType? keyboardType,

    int? maxLength,

  }) {

    return TextFormField(

      controller: controller,

      keyboardType: keyboardType,

      maxLength: maxLength,

      validator: (value) {

        if (value == null || value.trim().isEmpty) {

          return '$label is required';

        }



        if (label == 'Mobile Number' &&

            value.trim().length != 10) {

          return 'Enter a valid 10 digit mobile number';

        }



        return null;

      },

      style: const TextStyle(

        fontSize: 15,

        fontWeight: FontWeight.w500,

      ),

      decoration: InputDecoration(

        labelText: label,

        hintText: hint,

        prefixIcon: Icon(icon),

        filled: true,

        fillColor: Colors.white.withValues(alpha: 0.055),

        counterText: '',

        labelStyle: TextStyle(

          color: Colors.white.withValues(alpha: 0.55),

        ),

        hintStyle: TextStyle(

          color: Colors.white.withValues(alpha: 0.25),

        ),

        prefixIconColor: const Color(0xFF19B5FE),

        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(17),

          borderSide: BorderSide(

            color: Colors.white.withValues(alpha: 0.08),

          ),

        ),

        focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(17),

          borderSide: const BorderSide(

            color: Color(0xFF19B5FE),

            width: 1.4,

          ),

        ),

        errorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(17),

          borderSide: const BorderSide(

            color: Colors.redAccent,

          ),

        ),

        focusedErrorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(17),

          borderSide: const BorderSide(

            color: Colors.redAccent,

          ),

        ),

      ),

    );

  }



  Widget _businessDropdown() {

    return DropdownButtonFormField<String>(

      initialValue: _businessType,

      decoration: InputDecoration(

        labelText: 'Business Type',

        prefixIcon: const Icon(

          Icons.category_outlined,

          color: Color(0xFF19B5FE),

        ),

        filled: true,

        fillColor: Colors.white.withValues(alpha: 0.055),

        labelStyle: TextStyle(

          color: Colors.white.withValues(alpha: 0.55),

        ),

        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(17),

          borderSide: BorderSide(

            color: Colors.white.withValues(alpha: 0.08),

          ),

        ),

        focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(17),

          borderSide: const BorderSide(

            color: Color(0xFF19B5FE),

            width: 1.4,

          ),

        ),

      ),

      dropdownColor: const Color(0xFF102238),

      items: _businessTypes.map((type) {

        return DropdownMenuItem(

          value: type,

          child: Text(type),

        );

      }).toList(),

      onChanged: (value) {

        if (value != null) {

          setState(() {

            _businessType = value;

          });

        }

      },

    );

  }



Future<void> _continueSetup() async {

  if (!_formKey.currentState!.validate()) {

    return;

  }



  FocusScope.of(context).unfocus();



  showDialog(

    context: context,

    barrierDismissible: false,

    builder: (_) {

      return const Center(

        child: CircularProgressIndicator(),

      );

    },

  );



  try {

    final shop = await client.shop.saveShop(

      shopName: _shopNameController.text.trim(),

      ownerName: _ownerNameController.text.trim(),

      businessType: _businessType,

      mobile: _mobileController.text.trim(),

      city: _cityController.text.trim(),

    );



    if (!mounted) return;



    Navigator.of(context).pop();



    Navigator.pushReplacement(

      context,

      _createRoute(

        DashboardScreen(

          shopName: shop.shopName,

          ownerName: shop.ownerName,

          businessType: shop.businessType,

        ),

      ),

    );

  } catch (e) {

    if (!mounted) return;



    Navigator.of(context).pop();



    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        content: Text(

          'Shop save failed: $e',

        ),

        backgroundColor: Colors.redAccent,

        behavior: SnackBarBehavior.floating,

      ),

    );

  }

}

}





// ============================================================

// DASHBOARD SCREEN

// ============================================================



class DashboardScreen extends StatefulWidget {

  final String shopName;

  final String ownerName;

  final String businessType;



  const DashboardScreen({

    super.key,

    required this.shopName,

    required this.ownerName,

    required this.businessType,

  });



  @override

  State<DashboardScreen> createState() => _DashboardScreenState();

}



class _DashboardScreenState extends State<DashboardScreen>



    with SingleTickerProviderStateMixin {


      

  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;

  late Animation<Offset> _slideAnimation;



  int _selectedIndex = 0;



late Future<Map<String, dynamic>> _dashboardFuture;

Future<Map<String, dynamic>> _loadDashboardData() async {
  final results = await Future.wait([
    client.sale.getSales(),
    client.product.getProducts(),
  ]);

  return <String, dynamic>{
    'sales': results[0],
    'products': results[1],
  };
}

void _refreshDashboard() {
  if (!mounted) return;
  setState(() {
    _dashboardFuture = _loadDashboardData();
  });
}

Future<void> _openBilling() async {
  await Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (_) => const BillingScreen(),
    ),
  );
  _refreshDashboard();
}

Future<void> _openInventory() async {
  await Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (_) => const InventoryScreen(),
    ),
  );
  _refreshDashboard();
}

void _openReports() {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => ReportsScreen(
        client: client,
      ),
    ),
  );
}



double _todaySalesTotal(List<dynamic> sales) {
  final now = DateTime.now();
  return sales.where((sale) {
    final createdAt = sale.createdAt as DateTime;
    return createdAt.year == now.year &&
        createdAt.month == now.month &&
        createdAt.day == now.day;
  }).fold<double>(
    0,
    (total, sale) => total + (sale.totalAmount as num).toDouble(),
  );
}

int _todayBillsCount(List<dynamic> sales) {
  final now = DateTime.now();
  return sales.where((sale) {
    final createdAt = sale.createdAt as DateTime;
    return createdAt.year == now.year &&
        createdAt.month == now.month &&
        createdAt.day == now.day;
  }).length;
}



  @override

  void initState() {

    super.initState();

_dashboardFuture = _loadDashboardData();

    _animationController = AnimationController(

      vsync: this,

      duration: const Duration(milliseconds: 900),

    );



    _fadeAnimation = CurvedAnimation(

      parent: _animationController,

      curve: Curves.easeOut,

    );



    _slideAnimation = Tween<Offset>(

      begin: const Offset(0, 0.06),

      end: Offset.zero,

    ).animate(

      CurvedAnimation(

        parent: _animationController,

        curve: Curves.easeOutCubic,

      ),

    );



    _animationController.forward();

  }



  @override

  void dispose() {

    _animationController.dispose();

    super.dispose();

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF07111F),

      body: SafeArea(

        child: FadeTransition(

          opacity: _fadeAnimation,

          child: SlideTransition(

            position: _slideAnimation,

            child: _buildDashboard(),

          ),

        ),

      ),

      bottomNavigationBar: _buildBottomNavigation(),

    );

  }



 Widget _buildDashboard() {
  return FutureBuilder<Map<String, dynamic>>(
    future: _dashboardFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF38BDF8),
          ),
        );
      }

      if (snapshot.hasError) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_off_rounded,
                  color: Colors.orangeAccent,
                  size: 48,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Dashboard data load nahi ho paya.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _dashboardFuture = _loadDashboardData();
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      }

      if (!snapshot.hasData) {
        return const Center(
          child: Text(
            'Dashboard data available nahi hai.',
            style: TextStyle(color: Colors.white70),
          ),
        );
      }

      final sales = (snapshot.data!['sales'] as List).cast<dynamic>();
      final products =
          (snapshot.data!['products'] as List).cast<dynamic>();
      final activeProducts =
          products.where((product) => product.isActive == true).toList();
      final lowStockProducts = activeProducts
          .where((product) =>
              (product.stockQuantity as int) <=
              (product.lowStockAlert as int))
          .toList();

      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildHeader(),
                  const SizedBox(height: 25),
                  _buildTodayCard(sales),
                  const SizedBox(height: 24),
                  _buildSectionTitle(
                    'Quick Actions',
                    'Manage your shop',
                  ),
                  const SizedBox(height: 14),
                  _buildQuickActions(),
                  const SizedBox(height: 28),
                  _buildSectionTitle(
                    'Business Overview',
                    'Today',
                  ),
                  const SizedBox(height: 14),
                  _buildStats(sales, activeProducts),
                  const SizedBox(height: 28),
                  _buildSectionTitle(
                    'Recent Sales',
                    'View all',
                  ),
                  const SizedBox(height: 14),
                  _buildRecentSales(sales),
                  const SizedBox(height: 28),
                  _buildLowStockCard(lowStockProducts),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}



  Widget _buildHeader() {

    return Row(

      children: [

        Container(

          width: 52,

          height: 52,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(17),

            gradient: const LinearGradient(

              colors: [

                Color(0xFF19B5FE),

                Color(0xFF6557FF),

              ],

            ),

          ),

          child: const Icon(

            Icons.storefront_rounded,

            color: Colors.white,

            size: 28,

          ),

        ),



        const SizedBox(width: 13),



        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                'Good day, ${widget.ownerName}',

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(

                  fontSize: 13,

                  color: Colors.white.withValues(alpha: 0.55),

                ),

              ),

              const SizedBox(height: 3),

              Text(

                widget.shopName,

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

                style: const TextStyle(

                  fontSize: 20,

                  fontWeight: FontWeight.w800,

                ),

              ),

            ],

          ),

        ),



        Container(

          width: 44,

          height: 44,

          decoration: BoxDecoration(

            color: Colors.white.withValues(alpha: 0.06),

            borderRadius: BorderRadius.circular(15),

          ),

          child: IconButton(

            onPressed: () {},

            icon: const Icon(

              Icons.notifications_none_rounded,

              size: 23,

            ),

          ),

        ),

      ],

    );

  }



  Widget _buildTodayCard(List<dynamic> sales) {
    final total = _todaySalesTotal(sales);
    final billsToday = _todayBillsCount(sales);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1177D1),
            Color(0xFF194FA3),
            Color(0xFF40318F),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF19B5FE).withValues(alpha: 0.14),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.trending_up_rounded, size: 19),
              const SizedBox(width: 7),
              Text(
                "TODAY'S SALES",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: Colors.white.withValues(alpha: 0.72),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            '₹${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            billsToday == 0
                ? 'No sales recorded today yet'
                : '$billsToday bill${billsToday == 1 ? '' : 's'} recorded today',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _openBilling,
              icon: const Icon(Icons.add_rounded, size: 21),
              label: const Text(
                'Create New Bill',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1459A8),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {

    return GridView.count(

      crossAxisCount: 2,

      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      mainAxisSpacing: 12,

      crossAxisSpacing: 12,

      childAspectRatio: 1.65,

      children: [

        _quickAction(

          Icons.point_of_sale_rounded,

          'New Bill',

          'Create invoice',

        ),

        _quickAction(

          Icons.inventory_2_rounded,

          'Inventory',

          'Manage products',

        ),

        _quickAction(

          Icons.people_alt_outlined,

          'Customers',

          'View khata',

        ),

        _quickAction(

          Icons.shopping_cart_checkout_rounded,

          'Purchase',

          'Add stock',

        ),

      ],

    );

  }



  Widget _quickAction(

    IconData icon,

    String title,

    String subtitle,

  ) {

    return InkWell(

      borderRadius: BorderRadius.circular(20),

    onTap: () {

if (title == 'New Bill') {
  _openBilling();
  return;
}



  if (title == 'Inventory') {
    _openInventory();
    return;
  }

  if (title == 'Customers') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CustomerScreen(),
      ),
    );
    return;
  }

  if (title == 'Purchase') {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const PurchaseScreen(),
    ),
  );
  return;
}
},

      child: Container(

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(

          color: Colors.white.withValues(alpha: 0.055),

          borderRadius: BorderRadius.circular(20),

          border: Border.all(

            color: Colors.white.withValues(alpha: 0.07),

          ),

        ),

        child: Row(

          children: [

            Container(

              width: 43,

              height: 43,

              decoration: BoxDecoration(

                color: const Color(0xFF19B5FE).withValues(alpha: 0.12),

                borderRadius: BorderRadius.circular(14),

              ),

              child: Icon(

                icon,

                color: const Color(0xFF19B5FE),

                size: 21,

              ),

            ),



            const SizedBox(width: 11),



            Expanded(

              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment:

                    CrossAxisAlignment.start,

                children: [

                  Text(

                    title,

                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(

                      fontSize: 13,

                      fontWeight: FontWeight.w700,

                    ),

                  ),

                  const SizedBox(height: 3),

                  Text(

                    subtitle,

                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(

                      fontSize: 10,

                      color: Colors.white.withValues(alpha: 0.40),

                    ),

                  ),

                ],

              ),

            ),

          ],

        ),

      ),

    );

  }



  Widget _buildSectionTitle(

    String title,

    String action,

  ) {

    return Row(

      children: [

        Text(

          title,

          style: const TextStyle(

            fontSize: 18,

            fontWeight: FontWeight.w800,

          ),

        ),

        const Spacer(),

        Text(

          action,

          style: const TextStyle(

            fontSize: 12,

            color: Color(0xFF19B5FE),

            fontWeight: FontWeight.w600,

          ),

        ),

      ],

    );

  }



  Widget _buildStats(
    List<dynamic> sales,
    List<dynamic> activeProducts,
  ) {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            Icons.receipt_long_rounded,
            'Bills',
            '${sales.length}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            Icons.inventory_2_rounded,
            'Products',
            '${activeProducts.length}',
          ),
        ),
      ],
    );
  }

  Widget _statCard(

    IconData icon,

    String title,

    String value,

  ) {

    return Container(

      padding: const EdgeInsets.all(17),

      decoration: BoxDecoration(

        color: Colors.white.withValues(alpha: 0.055),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(

          color: Colors.white.withValues(alpha: 0.07),

        ),

      ),

      child: Column(

        crossAxisAlignment:

            CrossAxisAlignment.start,

        children: [

          Icon(

            icon,

            color: const Color(0xFF19B5FE),

            size: 22,

          ),

          const SizedBox(height: 14),

          Text(

            value,

            style: const TextStyle(

              fontSize: 25,

              fontWeight: FontWeight.w900,

            ),

          ),

          const SizedBox(height: 3),

          Text(

            title,

            style: TextStyle(

              fontSize: 12,

              color: Colors.white.withValues(alpha: 0.45),

            ),

          ),

        ],

      ),

    );

  }



  Widget _buildRecentSales(List<dynamic> sales) {
    final recentSales = List<dynamic>.from(sales)
      ..sort((a, b) =>
          (b.createdAt as DateTime).compareTo(a.createdAt as DateTime));
    final visibleSales = recentSales.take(5).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.045),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
        ),
      ),
      child: visibleSales.isEmpty
          ? Column(
              children: [
                const Icon(
                  Icons.receipt_long_outlined,
                  size: 38,
                  color: Color(0xFF19B5FE),
                ),
                const SizedBox(height: 10),
                const Text(
                  'No sales yet',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Your recent bills will appear here',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.40),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                for (var i = 0; i < visibleSales.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 18,
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFF19B5FE)
                              .withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.receipt_long_rounded,
                          color: Color(0xFF19B5FE),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${visibleSales[i].invoiceNumber}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatSaleDate(
                                visibleSales[i].createdAt as DateTime,
                              ),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹${(visibleSales[i].totalAmount as num).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF35D39A),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
    );
  }

  String _formatSaleDate(DateTime date) {
    final localDate = date.toLocal();
    final hour = localDate.hour % 12 == 0 ? 12 : localDate.hour % 12;
    final minute = localDate.minute.toString().padLeft(2, '0');
    final period = localDate.hour >= 12 ? 'PM' : 'AM';
    return '${localDate.day.toString().padLeft(2, '0')}/'
        '${localDate.month.toString().padLeft(2, '0')}/'
        '${localDate.year} • $hour:$minute $period';
  }

  Widget _buildLowStockCard(List<dynamic> lowStockProducts) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFA726).withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFA726).withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFFFA726).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFFFA726),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Stock Alert',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  lowStockProducts.isEmpty
                      ? 'No low-stock products'
                      : '${lowStockProducts.length} product(s) need restocking',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
                if (lowStockProducts.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  for (final product in lowStockProducts.take(3))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        '${product.name} • ${product.stockQuantity} ${product.unit} left',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFFC266),
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  
Widget _buildBottomNavigation() {
  return NavigationBar(
    backgroundColor: const Color(0xFF091625),
    indicatorColor: const Color(0xFF19B5FE).withValues(alpha: 0.15),
    selectedIndex: _selectedIndex,

    onDestinationSelected: (index) async {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          // Home: current dashboard stays visible.
          break;

        case 1:
          await _openBilling();
          break;

        case 2:
          await _openInventory();
          break;

        case 3:
          if (!mounted) return;

          showModalBottomSheet<void>(
            context: context,
            backgroundColor: const Color(0xFF102238),
            showDragHandle: true,
            builder: (sheetContext) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'More Features',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 16),

                      ListTile(
                        leading: const Icon(
                          Icons.shopping_cart_rounded,
                          color: Color(0xFF19B5FE),
                        ),
                        title: const Text('Purchase History'),
                        subtitle: const Text(
                          'Purchases, suppliers and stock entries',
                        ),
                        onTap: () {
                          Navigator.pop(sheetContext);
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => const PurchaseScreen(),
                            ),
                          ).then((_) => _refreshDashboard());
                        },
                      ),

                      ListTile(
                        leading: const Icon(
                          Icons.bar_chart_rounded,
                          color: Color(0xFF35D39A),
                        ),
                        title: const Text('Reports & Profit/Loss'),
                        subtitle: const Text(
                          'Monthly sales, purchases and business reports',
                        ),
                        onTap: () {
                          Navigator.pop(sheetContext);
                          _openReports();
                        },
                      ),

                      ListTile(
                        leading: const Icon(
                          Icons.people_alt_rounded,
                          color: Color(0xFFFFC15A),
                        ),
                        title: const Text('Customers'),
                        subtitle: const Text('Customer records and khata'),
                        onTap: () {
                          Navigator.pop(sheetContext);
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => const CustomerScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          break;
      }
    },

    destinations: const [
      NavigationDestination(
        icon: Icon(Icons.dashboard_outlined),
        selectedIcon: Icon(Icons.dashboard_rounded),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(Icons.receipt_long_outlined),
        selectedIcon: Icon(Icons.receipt_long_rounded),
        label: 'Bills',
      ),
      NavigationDestination(
        icon: Icon(Icons.inventory_2_outlined),
        selectedIcon: Icon(Icons.inventory_2_rounded),
        label: 'Stock',
      ),
      NavigationDestination(
        icon: Icon(Icons.more_horiz_rounded),
        selectedIcon: Icon(Icons.more_horiz_rounded),
        label: 'More',
      ),
    ],
  );
}





}





// ============================================================

// SHARED UI

// ============================================================



class _GradientBackground extends StatelessWidget {

  const _GradientBackground();



  @override

  Widget build(BuildContext context) {

    return Container(

      decoration: const BoxDecoration(

        gradient: LinearGradient(

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,

          colors: [

            Color(0xFF07111F),

            Color(0xFF0B1E32),

            Color(0xFF07111F),

          ],

        ),

      ),

    );

  }

}



class _GoDukaanLogo extends StatelessWidget {

  const _GoDukaanLogo();



  @override

  Widget build(BuildContext context) {

    return Container(

      width: 105,

      height: 105,

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(30),

        gradient: const LinearGradient(

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,

          colors: [

            Color(0xFF19B5FE),

            Color(0xFF6557FF),

          ],

        ),

        boxShadow: [

          BoxShadow(

            color: const Color(0xFF19B5FE).withValues(alpha: 0.25),

            blurRadius: 35,

            spreadRadius: 4,

          ),

        ],

      ),

      child: const Center(

        child: Icon(

          Icons.storefront_rounded,

          size: 54,

          color: Colors.white,

        ),

      ),

    );

  }

}



class _FeatureRow extends StatelessWidget {

  final IconData icon;

  final String title;

  final String subtitle;



  const _FeatureRow({

    required this.icon,

    required this.title,

    required this.subtitle,

  });



  @override

  Widget build(BuildContext context) {

    return Row(

      children: [

        Container(

          width: 48,

          height: 48,

          decoration: BoxDecoration(

            color: const Color(0xFF19B5FE).withValues(alpha: 0.12),

            borderRadius: BorderRadius.circular(15),

          ),

          child: Icon(

            icon,

            color: const Color(0xFF19B5FE),

          ),

        ),

        const SizedBox(width: 14),

        Expanded(

          child: Column(

            crossAxisAlignment:

                CrossAxisAlignment.start,

            children: [

              Text(

                title,

                style: const TextStyle(

                  fontSize: 15,

                  fontWeight: FontWeight.w700,

                ),

              ),

              const SizedBox(height: 3),

              Text(

                subtitle,

                style: TextStyle(

                  fontSize: 12,

                  color: Colors.white.withValues(alpha: 0.48),

                ),

              ),

            ],

          ),

        ),

      ],

    );

  }

}



// ============================================================

// PAGE TRANSITION

// ============================================================



Route _createRoute(Widget page) {

  return PageRouteBuilder(

    pageBuilder: (

      context,

      animation,

      secondaryAnimation,

    ) =>

        page,

    transitionsBuilder: (

      context,

      animation,

      secondaryAnimation,

      child,

    ) {

      final slide = Tween<Offset>(

        begin: const Offset(0.15, 0),

        end: Offset.zero,

      ).animate(

        CurvedAnimation(

          parent: animation,

          curve: Curves.easeOutCubic,

        ),

      );



      return FadeTransition(

        opacity: animation,

        child: SlideTransition(

          position: slide,

          child: child,

        ),

      );

    },

  );

}