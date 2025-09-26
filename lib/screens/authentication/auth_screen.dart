import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tebbi/blocs/authentication/login_bloc/login_bloc.dart';
import 'package:tebbi/blocs/authentication/registration_bloc/registration_bloc.dart';
import 'package:tebbi/blocs/authentication/user_on_device_status_bloc/user_on_device_status_bloc.dart';
import 'package:tebbi/configs/app_colors.dart';
import 'package:tebbi/models/login_request_model.dart';
import 'package:tebbi/models/registration_request_model.dart';
import 'package:tebbi/repositories/authentication_repository.dart';
import 'package:tebbi/screens/home/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  // Tabs
  int _currentIndex = 0; // 0 = Login, 1 = Register

  // Animation controllers
  late final AnimationController _logoBounceController;
  late final Animation<double> _logoBounceAnimation;

  // Forms
  final _loginKey = GlobalKey<FormState>();
  final _registerKey = GlobalKey<FormState>();

  // Login controllers
  final TextEditingController _loginEmail = TextEditingController();
  final TextEditingController _loginPassword = TextEditingController();

  // Register controllers
  final TextEditingController _regName = TextEditingController();
  final TextEditingController _regEmail = TextEditingController();
  final TextEditingController _regPhone = TextEditingController();
  int _regGender = 0; // 0 male, 1 female
  final TextEditingController _regPassword = TextEditingController();
  final TextEditingController _regPasswordConfirm = TextEditingController();
  late final LoginBloc _loginBloc;
  late final RegistrationBloc _registrationBloc;
  late final UserOnDeviceStatusBloc _userOnDeviceStatusBloc;
  UserOnDeviceStatusState userOnDeviceStatusState = UserOnDeviceStatusInitial();

  bool isLoading = false;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _userOnDeviceStatusBloc = UserOnDeviceStatusBloc()
      ..add(const UserOnDeviceStatusCheckStarted())
      ..stream.listen((UserOnDeviceStatusState state) {
        userOnDeviceStatusState = state;
      });

    _logoBounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _logoBounceAnimation = Tween<double>(begin: 1.0, end: 1.06)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(_logoBounceController);
    _loginBloc = LoginBloc(AuthenticationRepository())
      ..stream.listen((LoginState state) {
        if (state is LoginLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is LoginSuccess) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You have logged in successfully')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state is LoginFailure) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to log in with these data.')),
          );
        }
      });
    _registrationBloc = RegistrationBloc(AuthenticationRepository())
      ..stream.listen((RegistrationState state) {
        if (state is RegistrationLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is RegistrationSuccess) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You have Registered successfully')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state is RegistrationFailure) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to register with these data.'),
            ),
          );
        }
      });
    _timer = Timer(const Duration(seconds: 1), () {
      if (userOnDeviceStatusState is UserOnDeviceStatusChangedState) {
        final UserOnDeviceStatusChangedState userOnDeviceStatusChangedState =
            userOnDeviceStatusState as UserOnDeviceStatusChangedState;
        switch (userOnDeviceStatusChangedState.status) {
          case UserOnDeviceStatus.doesntExist:
            _userOnDeviceStatusBloc.add(
              const UserOnDeviceStatusChanged(UserOnDeviceStatus.doesntExist),
            );
          case UserOnDeviceStatus.exists:
            _loginBloc.add(
              LoginStarted(
                request: LoginRequest(
                  email:
                      (userOnDeviceStatusState
                              as UserOnDeviceStatusChangedState)
                          .email!,
                  password:
                      (userOnDeviceStatusState
                              as UserOnDeviceStatusChangedState)
                          .password!,
                ),
              ),
            );
        }
      }
    });
  }

  @override
  void dispose() {
    _logoBounceController.dispose();
    _loginEmail.dispose();
    _loginPassword.dispose();
    _regName.dispose();
    _regEmail.dispose();
    _regPhone.dispose();
    _regPassword.dispose();
    _regPasswordConfirm.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _switchTab(int index) {
    setState(() => _currentIndex = index);
    _logoBounceController.forward(from: 0.0);
  }

  void _onLogin() {
    if (_loginKey.currentState!.validate()) {
      _loginBloc.add(
        LoginStarted(
          request: LoginRequest(
            email: _loginEmail.text.trim(),
            password: _loginPassword.text,
          ),
        ),
      );
    }
  }

  void _onRegister() {
    if (_registerKey.currentState!.validate()) {
      _registrationBloc.add(
        RegistrationStarted(
          request: RegistrationRequest(
            name: _regName.text.trim(),
            email: _regEmail.text.trim(),
            phone: _regPhone.text.trim(),
            gender: _regGender,
            password: _regPassword.text,
            passwordConfirmation: _regPasswordConfirm.text,
          ),
        ),
      );
    }
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _logoBounceAnimation,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                padding: const EdgeInsets.all(12),
                child: Image.asset("assets/images/app_logo.png", height: 120),
              ),
            ),

            // Tabs (custom)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Row(
                  children: [
                    _tabButton(label: 'Login', index: 0),
                    _tabButton(label: 'Register', index: 1),
                  ],
                ),
              ),
            ),

            // Animated forms area
            isLoading
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 450),
                        transitionBuilder: (child, animation) {
                          final inAnim = Tween<Offset>(
                            begin: const Offset(0.0, 0.1),
                            end: Offset.zero,
                          ).animate(animation);
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: inAnim,
                              child: child,
                            ),
                          );
                        },
                        child: _currentIndex == 0
                            ? _buildLogin(colorScheme)
                            : _buildRegister(colorScheme),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton({required String label, required int index}) {
    final selected = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _switchTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selected ? AppColors.onPrimary : AppColors.onSecondary,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogin(ColorScheme colorScheme) {
    return Form(
      key: _loginKey,
      child: Column(
        key: const ValueKey('login'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          TextFormField(
            controller: _loginEmail,
            decoration: _inputDecoration(label: 'Email', icon: Icons.email),
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Email is required';
              final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
              if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _loginPassword,
            decoration: _inputDecoration(label: 'Password', icon: Icons.lock),
            obscureText: true,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Password is required';
              if (v.length < 6) return 'Password must be at least 6 characters';
              return null;
            },
          ),
          const SizedBox(height: 20),

          AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 150),
            child: ElevatedButton(
              onPressed: _onLogin,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegister(ColorScheme colorScheme) {
    return SingleChildScrollView(
      key: const ValueKey('register'),
      child: Form(
        key: _registerKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _regName,
              decoration: _inputDecoration(
                label: 'Full Name',
                icon: Icons.person,
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Name is required';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _regEmail,
              decoration: _inputDecoration(label: 'Email', icon: Icons.email),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email is required';
                final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
                if (!emailRegex.hasMatch(v.trim())) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _regPhone,
              decoration: _inputDecoration(label: 'Phone', icon: Icons.phone),
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Phone is required';
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Gender selector
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _regGender = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: _regGender == 0
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _regGender == 0
                              ? AppColors.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        'Male',
                        style: TextStyle(
                          color: _regGender == 0
                              ? AppColors.primary
                              : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _regGender = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: _regGender == 1
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _regGender == 1
                              ? AppColors.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        'Female',
                        style: TextStyle(
                          color: _regGender == 1
                              ? AppColors.primary
                              : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            TextFormField(
              controller: _regPassword,
              decoration: _inputDecoration(label: 'Password', icon: Icons.lock),
              obscureText: true,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Password is required';
                if (v.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _regPasswordConfirm,
              decoration: _inputDecoration(
                label: 'Confirm Password',
                icon: Icons.lock_outline,
              ),
              obscureText: true,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Confirmation is required';
                if (v != _regPassword.text) return 'Passwords do not match';
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Animated register button
            ElevatedButton(
              onPressed: _onRegister,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
