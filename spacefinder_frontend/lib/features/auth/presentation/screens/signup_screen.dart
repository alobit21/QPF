import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  void _signup() async {
    await ref.read(authProvider.notifier).register({
      'firstName': _firstNameCtrl.text.trim(),
      'lastName': _lastNameCtrl.text.trim(),
      'email': _emailCtrl.text.trim(),
      'password': _passCtrl.text,
      'role': 'customer', // default role
    });
    
    final state = ref.read(authProvider);
    if (state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup failed: ${state.error}')));
    } else if (state.value != null) {
      if (context.canPop()) {
        context.pop(); // pops signup
        if (context.canPop()) context.pop(); // pops login if it was on stack
      } else {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: AppColors.foreground),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.foreground)),
              const SizedBox(height: 8),
              const Text('Sign up to start booking amazing spaces.', style: TextStyle(color: AppColors.mutedForeground)),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _firstNameCtrl,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        filled: true,
                        fillColor: AppColors.card,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _lastNameCtrl,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        filled: true,
                        fillColor: AppColors.card,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: authState.isLoading ? null : _signup,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: authState.isLoading ? AppColors.mutedForeground : AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: authState.isLoading
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: AppColors.primaryForeground, strokeWidth: 2))
                    : const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryForeground)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
