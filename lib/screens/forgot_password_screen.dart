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
              AppBar(
                title: const Text('Recuperar Contraseña'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: Stepper(
                  type: StepperType.vertical,
                  physics: const ClampingScrollPhysics(),
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
                      content: _buildTextField(_emailController, 'Ingresa tu correo electrónico', Icons.email),
                      isActive: _currentStep >= 0,
                    ),
                    Step(
                      title: const Text('Código de Verificación', style: TextStyle(color: Colors.white)),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Te hemos enviado un código de verificación a tu correo electrónico',
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(_codeController, 'Ingresa el código', Icons.lock_clock),
                        ],
                      ),
                      isActive: _currentStep >= 1,
                    ),
                    Step(
                      title: const Text('Nueva Contraseña', style: TextStyle(color: Colors.white)),
                      content: Column(
                        children: [
                          _buildPasswordField(_newPasswordController, 'Nueva contraseña', _isPasswordVisible, (visible) {
                            setState(() {
                              _isPasswordVisible = visible;
                            });
                          }),
                          const SizedBox(height: 15),
                          _buildPasswordField(_confirmPasswordController, 'Confirmar contraseña', _isConfirmPasswordVisible, (visible) {
                            setState(() {
                              _isConfirmPasswordVisible = visible;
                            });
                          }),
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