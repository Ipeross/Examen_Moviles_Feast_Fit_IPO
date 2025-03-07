import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IntoleranciasScreen extends StatefulWidget {
  @override
  _IntoleranciasScreenState createState() => _IntoleranciasScreenState();
}

class _IntoleranciasScreenState extends State<IntoleranciasScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> _removeIntolerancia(String intolerancia) async {
    if (user != null) {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('intolerancias').doc(user!.uid);
      DocumentSnapshot docSnap = await docRef.get();
      if (docSnap.exists) {
        List<dynamic> intolerancias = docSnap['nombres'] ?? [];
        intolerancias.remove(intolerancia);
        await docRef.update({'nombres': intolerancias});
      }
    }
  }

  void _navigateToAddIntoleranciaForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddIntoleranciaScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Intolerancias")),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('intolerancias')
            .doc(user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("No hay intolerancias"));
          }

          List<dynamic> intolerancias = snapshot.data!['nombres'] ?? [];

          return ListView.builder(
            itemCount: intolerancias.length,
            itemBuilder: (context, index) {
              String intolerancia = intolerancias[index];
              return ListTile(
                title: Text(intolerancia),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeIntolerancia(intolerancia),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddIntoleranciaForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddIntoleranciaScreen extends StatefulWidget {
  @override
  _AddIntoleranciaScreenState createState() => _AddIntoleranciaScreenState();
}

class _AddIntoleranciaScreenState extends State<AddIntoleranciaScreen> {
  final TextEditingController _controller = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> _addIntolerancia() async {
    if (user != null && _controller.text.isNotEmpty) {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('intolerancias').doc(user!.uid);
      DocumentSnapshot docSnap = await docRef.get();
      if (docSnap.exists) {
        List<dynamic> intolerancias = docSnap['nombres'] ?? [];
        intolerancias.add(_controller.text);
        await docRef.update({'nombres': intolerancias});
      } else {
        await docRef.set({
          'userId': user!.uid,
          'nombres': [_controller.text],
        });
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Añadir Intolerancia")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Nueva intolerancia",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addIntolerancia,
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
