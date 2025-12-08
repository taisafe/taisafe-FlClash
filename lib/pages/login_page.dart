// Login Page - iOS 26 Clean Style
// Authentication page with email/password login

import 'package:fl_clash/api/v2board_api.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/v2board_provider.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  final VoidCallback? onLoginSuccess;
  final VoidCallback? onNavigateToRegister;
  
  const LoginPage({
    super.key,
    this.onLoginSuccess,
    this.onNavigateToRegister,
  });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = true;
  String? _errorMessage;
  
  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }
  
  Future<void> _loadSavedEmail() async {
    final email = await ref.read(authTokenProvider.notifier).getSavedEmail();
    if (email != null && mounted) {
      setState(() {
        _emailController.text = email;
      });
    }
  }
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      final success = await ref.read(loginActionProvider.notifier).login(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (success && mounted) {
        widget.onLoginSuccess?.call();
      }
    } on V2BoardApiError catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.message;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = '登录失败，请检查网络连接';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo/Title Section
                    _buildHeader(textTheme, colorScheme),
                    const SizedBox(height: 48),
                    
                    // Error Message
                    if (_errorMessage != null) ...[
                      _buildErrorCard(colorScheme),
                      const SizedBox(height: 16),
                    ],
                    
                    // Email Field
                    _buildEmailField(colorScheme),
                    const SizedBox(height: 16),
                    
                    // Password Field
                    _buildPasswordField(colorScheme),
                    const SizedBox(height: 24),
                    
                    // Remember Me & Forgot Password
                    _buildOptionsRow(colorScheme, textTheme),
                    const SizedBox(height: 32),
                    
                    // Login Button
                    _buildLoginButton(colorScheme),
                    const SizedBox(height: 24),
                    
                    // Register Link
                    _buildRegisterLink(colorScheme, textTheme),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      children: [
        // App Icon Placeholder
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.shield_outlined,
            size: 40,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          '台安加速器',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '安全 · 快速 · 稳定',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
  
  Widget _buildErrorCard(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.error.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: colorScheme.error,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: TextStyle(
                color: colorScheme.error,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmailField(ColorScheme colorScheme) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      enableSuggestions: false,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: '邮箱',
        hintText: '请输入邮箱地址',
        prefixIcon: const Icon(Icons.email_outlined),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: colorScheme.error,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入邮箱';
        }
        if (!value.contains('@')) {
          return '请输入有效的邮箱地址';
        }
        return null;
      },
    );
  }
  
  Widget _buildPasswordField(ColorScheme colorScheme) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: '密码',
        hintText: '请输入密码',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword 
              ? Icons.visibility_outlined 
              : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入密码';
        }
        if (value.length < 6) {
          return '密码长度至少6位';
        }
        return null;
      },
    );
  }
  
  Widget _buildOptionsRow(ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember Me
        Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value ?? true;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '记住我',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        // Forgot Password
        TextButton(
          onPressed: _showForgotPasswordDialog,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            '忘记密码？',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildLoginButton(ColorScheme colorScheme) {
    return FilledButton(
      onPressed: _isLoading ? null : _handleLogin,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: colorScheme.primary,
      ),
      child: _isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colorScheme.onPrimary,
            ),
          )
        : Text(
            '登录',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
    );
  }
  
  Widget _buildRegisterLink(ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '还没有账号？',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: widget.onNavigateToRegister,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            '立即注册',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
  
  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('重置密码'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('请输入您的注册邮箱，我们将发送重置密码链接。'),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: '邮箱',
                hintText: '请输入邮箱地址',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              final email = emailController.text.trim();
              if (email.isEmpty || !email.contains('@')) {
                return;
              }
              try {
                await v2boardApi.forgotPassword(email);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('重置邮件已发送，请查收')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('发送失败：$e')),
                  );
                }
              }
            },
            child: const Text('发送'),
          ),
        ],
      ),
    );
  }
}
