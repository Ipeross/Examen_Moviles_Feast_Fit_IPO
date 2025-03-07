import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IntoleranciasScreen extends StatefulWidget {
  @override
  _IntoleranciasScreenState createState() => _IntoleranciasScreenState();
}

class _IntoleranciasScreenState extends State<IntoleranciasScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> _removeIntolerancia(String docId) async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('intolerancias')
          .doc(docId)
          .delete();
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('intolerancias')
            .where('userId', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var intolerancias = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: intolerancias.length,
            itemBuilder: (context, index) {
              var doc = intolerancias[index];
              String intolerancia = doc['nombre'];
              return ListTile(
                title: Text(intolerancia),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeIntolerancia(doc.id),
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
      await FirebaseFirestore.instance.collection('intolerancias').add({
        'nombre': _controller.text,
        'userId': user!.uid,
      });
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
            TextField(
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
