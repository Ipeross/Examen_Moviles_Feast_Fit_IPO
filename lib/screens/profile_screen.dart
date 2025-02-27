import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar3(title: 'Perfil'),
      body: FutureBuilder(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else if (snapshot.hasData) {
            final userData = snapshot.data!;
            return Container(
              color: Colors.brown[50], 
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Perfil de Usuario',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[800],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildUserInfo('Nombre', userData['name']),
                        _buildUserInfo('Correo', userData['email']),
                        _buildUserInfo('Peso', '${userData['weight']} kg'),
                        _buildUserInfo('Altura', '${userData['height']} cm'),
                        _buildUserInfo('Actividad Deportiva', userData['sportActivity']),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No hay datos disponibles'));
          }
        },
      ),
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser ;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return doc.data()!;
      }
    }
    return {};
  }
}