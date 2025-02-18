import 'package:feast_fit/screens/screens.dart';
import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  void _signUpWithGoogle() async {
    // Aquí irá la integración con Firebase Auth
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedGradientBackground(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_add_outlined,
                    size: 80, color: Colors.white),
                const SizedBox(height: 30),
                const Text('Crear Cuenta',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Nombre completo',
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: const TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Por favor ingresa tu nombre'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Correo electrónico',
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: const TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu correo';
                          }
                          if (!value.contains('@')) {
                            return 'Ingresa un correo válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.white70),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white24,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: const TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa una contraseña';
                          }
                          if (value.length < 8) {
                            return 'La contraseña debe tener al menos 8 caracteres';
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'La contraseña debe contener al menos una letra mayúscula';
                          }
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'La contraseña debe contener al menos un número';
                          }
                          if (!value
                              .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return 'La contraseña debe contener al menos un signo de puntuación';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue.shade700,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Registrarse',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white70,
                              thickness: 1,
                              indent: 20,
                              endIndent: 10,
                            ),
                          ),
                          Text(
                            'O',
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white70,
                              thickness: 1,
                              indent: 10,
                              endIndent: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton.icon(
                        onPressed: _signUpWithGoogle,
                        icon: Image.asset(
                          'assets/google_logo.png',
                          height: 24,
                          width: 24,
                        ),
                        label: const Text(
                          'Registrarse con Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('¿Ya tienes una cuenta?',
                              style: TextStyle(color: Colors.white70)),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Inicia Sesión',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}