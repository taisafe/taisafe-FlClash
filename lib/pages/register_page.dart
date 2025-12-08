// Register Page - iOS 26 Clean Style
// Registration page with email/password signup

import 'package:fl_clash/api/v2board_api.dart';
import 'package:fl_clash/providers/v2board_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  final VoidCallback? onRegisterSuccess;
  final VoidCallback? onNavigateToLogin;
  
  const RegisterPage({
    super.key,
    this.onRegisterSuccess,
    this.onNavigateToLogin,
  });

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  String? _errorMessage;
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }
  
  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (!_acceptTerms) {
      setState(() {
        _errorMessage = '请阅读并同意服务条款';
      });
      return;
    }
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      final success = await ref.read(registerActionProvider.notifier).register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        inviteCode: _inviteCodeController.text.isNotEmpty 
          ? _inviteCodeController.text.trim() 
          : null,
      );
      
      if (success && mounted) {
        widget.onRegisterSuccess?.call();
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
          _errorMessage = '注册失败，请稍后重试';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
          onPressed: widget.onNavigateToLogin,
        ),
      ),
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
                    // Header
                    _buildHeader(textTheme, colorScheme),
                    const SizedBox(height: 40),
                    
                    // Error Message
                    if (_errorMessage != null) ...[
                      _buildErrorCard(colorScheme),
                      const SizedBox(height: 16),
                    ],
                    
                    // Email Field
                    _buildTextField(
                      controller: _emailController,
                      label: '邮箱',
                      hint: '请输入邮箱地址',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '请输入邮箱';
                        }
                        if (!value.contains('@')) {
                          return '请输入有效的邮箱地址';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Password Field
                    _buildPasswordField(
                      controller: _passwordController,
                      label: '密码',
                      hint: '请输入密码（至少8位）',
                      obscure: _obscurePassword,
                      onToggle: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '请输入密码';
                        }
                        if (value.length < 8) {
                          return '密码长度至少8位';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Confirm Password Field
                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      label: '确认密码',
                      hint: '请再次输入密码',
                      obscure: _obscureConfirmPassword,
                      onToggle: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '请确认密码';
                        }
                        if (value != _passwordController.text) {
                          return '两次密码不一致';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Invite Code Field (Optional)
                    _buildTextField(
                      controller: _inviteCodeController,
                      label: '邀请码（选填）',
                      hint: '请输入邀请码',
                      icon: Icons.card_giftcard_outlined,
                      required: false,
                    ),
                    const SizedBox(height: 24),
                    
                    // Terms Checkbox
                    _buildTermsCheckbox(colorScheme, textTheme),
                    const SizedBox(height: 24),
                    
                    // Register Button
                    _buildRegisterButton(colorScheme),
                    const SizedBox(height: 24),
                    
                    // Login Link
                    _buildLoginLink(colorScheme, textTheme),
                    const SizedBox(height: 32),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '创建账号',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '注册台安加速器，开始安全上网之旅',
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
          Icon(Icons.error_outline, color: colorScheme.error, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: TextStyle(color: colorScheme.error, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool required = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autocorrect: false,
      enableSuggestions: false,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
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
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      validator: required ? validator : null,
    );
  }
  
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: onToggle,
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
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      validator: validator,
    );
  }
  
  Widget _buildTermsCheckbox(ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: _acceptTerms,
            onChanged: (value) {
              setState(() {
                _acceptTerms = value ?? false;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Wrap(
            children: [
              Text(
                '我已阅读并同意',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Show terms
                },
                child: Text(
                  '服务条款',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
              Text(
                '和',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Show privacy policy
                },
                child: Text(
                  '隐私政策',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildRegisterButton(ColorScheme colorScheme) {
    return FilledButton(
      onPressed: _isLoading ? null : _handleRegister,
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
            '注册',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
    );
  }
  
  Widget _buildLoginLink(ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '已有账号？',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: widget.onNavigateToLogin,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            '立即登录',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
