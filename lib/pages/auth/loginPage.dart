import 'package:diskonindonesia/pages/auth/registPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Color get bgColor => const Color(0xFF23282E); // Background dark
  Color get lightText => const Color(0xFFF5F5F5); // Text light
  Color get fieldFill => const Color(0xFF2E333A); // Input field fill

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                'Masuk Akun',
                style: TextStyle(
                  color: lightText,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Silakan login menggunakan email dan password.',
                style: TextStyle(
                  color: lightText.withOpacity(0.7),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'email@example.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hint: '••••••••',
                      icon: Icons.lock_outline,
                      obscureText: true,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightText,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: bgColor)
                            : Text(
                                'Masuk',
                                style: TextStyle(
                                  color: bgColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage())),
                      child: Text(
                        'Belum punya akun? Daftar',
                        style: TextStyle(color: lightText.withOpacity(0.8)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(color: lightText),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: lightText.withOpacity(0.7)),
        hintText: hint,
        hintStyle: TextStyle(color: lightText.withOpacity(0.4)),
        prefixIcon: Icon(icon, color: lightText.withOpacity(0.6)),
        filled: true,
        fillColor: fieldFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
