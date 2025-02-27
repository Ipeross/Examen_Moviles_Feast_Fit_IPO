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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nombre: ${userData['name']}', style: const TextStyle(fontSize: 20)),
                  Text('Correo: ${userData['email']}', style: const TextStyle(fontSize: 20)),
                  Text('Peso: ${userData['weight']} kg', style: const TextStyle(fontSize: 20)),
                  Text('Altura: ${userData['height']} cm', style: const TextStyle(fontSize: 20)),
                  Text('Actividad Deportiva: ${userData['sportActivity']}', style: const TextStyle(fontSize: 20)),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No hay datos disponibles'));
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return doc.data()!;
      }
    }
    return {};
  }
}
