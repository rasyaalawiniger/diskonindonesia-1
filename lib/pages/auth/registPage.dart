import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  XFile? profileImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImage = pickedFile;
      });
    }
  }

  void handleRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        // TODO: Upload profile image to Supabase bucket "profileimage" if selected
        String? profileImageUrl;
        if (profileImage != null) {
          // TODO: Upload to bucket "profileimage"
          // final storageResponse = await supabase.storage
          //     .from('profileimage')
          //     .upload('profile_${DateTime.now().millisecondsSinceEpoch}.jpg', 
          //            File(profileImage!.path));
          // profileImageUrl = supabase.storage
          //     .from('profileimage')
          //     .getPublicUrl(storageResponse.path);
        }

        // TODO: Insert user data to users table
        // final response = await supabase.from('users').insert({
        //   'name': nameController.text.trim(),
        //   'email': emailController.text.trim(),
        //   'phone': phoneController.text.trim(),
        //   'profilepicture': profileImageUrl,
        //   'points': 0,
        // });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mendaftarkan user...')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void navigateToLogin() {
    // TODO: Navigate to login page
    // Navigator.pushNamed(context, '/login');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigasi ke halaman login...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const darkColor = Color(0xFF23282E);
    const lightColor = Color(0xFFF5F5F5);
    
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    
                    // Header Section
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: lightColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person_add_alt_1,
                            color: lightColor,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Daftar Akun',
                          style: TextStyle(
                            color: lightColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Buat akun baru untuk memulai',
                          style: TextStyle(
                            color: lightColor.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Form Section
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Profile Image Picker
                          GestureDetector(
                            onTap: pickImage,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: lightColor.withOpacity(0.1),
                                  backgroundImage: profileImage != null
                                      ? Image.file(
                                          File(profileImage!.path),
                                          fit: BoxFit.cover,
                                        ).image
                                      : null,
                                  child: profileImage == null
                                      ? Icon(
                                          Icons.camera_alt_outlined,
                                          color: lightColor.withOpacity(0.6),
                                          size: 28,
                                        )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 4,
                                  right: 4,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: lightColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: darkColor,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Name Field
                          TextFormField(
                            controller: nameController,
                            style: TextStyle(
                              color: lightColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                              labelStyle: TextStyle(
                                color: lightColor.withOpacity(0.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: lightColor.withOpacity(0.7),
                                size: 20,
                              ),
                              filled: true,
                              fillColor: lightColor.withOpacity(0.08),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: lightColor.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty 
                                ? 'Masukkan nama lengkap' 
                                : null,
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Email Field
                          TextFormField(
                            controller: emailController,
                            style: TextStyle(
                              color: lightColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: lightColor.withOpacity(0.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: lightColor.withOpacity(0.7),
                                size: 20,
                              ),
                              filled: true,
                              fillColor: lightColor.withOpacity(0.08),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: lightColor.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Format email tidak valid';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Phone Field
                          TextFormField(
                            controller: phoneController,
                            style: TextStyle(
                              color: lightColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Nomor Handphone',
                              labelStyle: TextStyle(
                                color: lightColor.withOpacity(0.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                Icons.phone_outlined,
                                color: lightColor.withOpacity(0.7),
                                size: 20,
                              ),
                              filled: true,
                              fillColor: lightColor.withOpacity(0.08),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: lightColor.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty 
                                ? 'Masukkan nomor handphone' 
                                : null,
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Password Field
                          TextFormField(
                            controller: passwordController,
                            style: TextStyle(
                              color: lightColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            obscureText: !isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: lightColor.withOpacity(0.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: lightColor.withOpacity(0.7),
                                size: 20,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: Icon(
                                  isPasswordVisible 
                                      ? Icons.visibility_off_outlined 
                                      : Icons.visibility_outlined,
                                  color: lightColor.withOpacity(0.7),
                                  size: 20,
                                ),
                              ),
                              filled: true,
                              fillColor: lightColor.withOpacity(0.08),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: lightColor.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan password';
                              }
                              if (value.length < 6) {
                                return 'Password minimal 6 karakter';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightColor,
                          foregroundColor: darkColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: handleRegister,
                        child: Text(
                          'Daftar Sekarang',
                          style: TextStyle(
                            color: darkColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Login Navigation
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya akun? ',
                            style: TextStyle(
                              color: lightColor.withOpacity(0.7),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: navigateToLogin,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Masuk',
                                style: TextStyle(
                                  color: lightColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: lightColor.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}