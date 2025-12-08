// Auth Wrapper - Handles authentication flow
// Shows login/register pages when not authenticated

import 'package:fl_clash/pages/login_page.dart';
import 'package:fl_clash/pages/register_page.dart';
import 'package:fl_clash/providers/v2board_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthPageType { login, register }

class AuthWrapper extends ConsumerStatefulWidget {
  final Widget child;
  
  const AuthWrapper({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  AuthPageType _currentPage = AuthPageType.login;
  
  @override
  void initState() {
    super.initState();
    // Try to restore auth state
    _initAuth();
  }
  
  Future<void> _initAuth() async {
    // Auth token will be loaded from SharedPreferences by the provider
    await Future.delayed(const Duration(milliseconds: 100));
  }
  
  void _navigateToLogin() {
    setState(() {
      _currentPage = AuthPageType.login;
    });
  }
  
  void _navigateToRegister() {
    setState(() {
      _currentPage = AuthPageType.register;
    });
  }
  
  void _onAuthSuccess() {
    // Just rebuild - the isLoggedIn state will change
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    
    if (isLoggedIn) {
      return widget.child;
    }
    
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: _currentPage == AuthPageType.login 
                ? const Offset(-0.1, 0) 
                : const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            )),
            child: child,
          ),
        );
      },
      child: _currentPage == AuthPageType.login
        ? LoginPage(
            key: const ValueKey('login'),
            onLoginSuccess: _onAuthSuccess,
            onNavigateToRegister: _navigateToRegister,
          )
        : RegisterPage(
            key: const ValueKey('register'),
            onRegisterSuccess: _onAuthSuccess,
            onNavigateToLogin: _navigateToLogin,
          ),
    );
  }
}
