import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Contraseña'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 83, 70, 70),
              Color.fromARGB(255, 105, 82, 64),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  currentStep: _currentStep,
                  onStepContinue: () {
                    if (_currentStep < 2) {
                      setState(() {
                        _currentStep++;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('¡Contraseña actualizada exitosamente!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  onStepCancel: () {
                    if (_currentStep > 0) {
                      setState(() {
                        _currentStep--;
                      });
                    }
                  },
                  steps: [
                    Step(
                      title: const Text('Verificar Email', style: TextStyle(color: Colors.white)),
                      content: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Ingresa tu correo electrónico',
                            prefixIcon: const Icon(Icons.email, color: Colors.white70),
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
                      ),
                      isActive: _currentStep >= 0,
                    ),
                    Step(
                      title: const Text('Código de Verificación', style: TextStyle(color: Colors.white)),
                      content: Column(
                        children: [
                          const Text(
                            'Te hemos enviado un código de verificación a tu correo electrónico',
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _codeController,
                            decoration: InputDecoration(
                              hintText: 'Ingresa el código',
                              prefixIcon: const Icon(Icons.lock_clock, color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white24,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: const TextStyle(color: Colors.white70),
                            ),
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 1,
                    ),
                    Step(
                      title: const Text('Nueva Contraseña', style: TextStyle(color: Colors.white)),
                      content: Column(
                        children: [
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Nueva contraseña',
                              prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
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
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: !_isConfirmPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Confirmar contraseña',
                              prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
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
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: Colors.white70),
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
    );
  }

   Widget _buildPasswordField(TextEditingController controller, String hintText, bool isVisible, Function(bool) toggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.lock, color: Colors.white70),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility, color: Colors.white70),
          onPressed: () => toggleVisibility(!isVisible),
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
