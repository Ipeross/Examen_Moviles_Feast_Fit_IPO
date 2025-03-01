import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodScreenAdmin extends StatefulWidget {
  const FoodScreenAdmin({super.key});

  @override
  _FoodScreenAdminState createState() => _FoodScreenAdminState();
}

class _FoodScreenAdminState extends State<FoodScreenAdmin> {
  String? selectedUserId;
  List<String> daysOfWeek = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    daysOfWeek = getDaysOfWeek();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> getDaysOfWeek() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final day = now.add(Duration(days: index));
      return "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    });
  }

  void addFoodToUser(String day, String mealType, String food) async {
    if (selectedUserId != null) {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(selectedUserId);

      await userRef.set(
          {
            "meals": {
              day: {
                mealType: FieldValue.arrayUnion([food])
              }
            }
          },
          SetOptions(
              merge: true)); // merge: true evita sobrescribir datos existentes
    }
  }

  void showFoodSelectionDialog(String day) {
    String selectedMealType = "Desayuno";
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Añadir plato"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedMealType,
                    onChanged: (value) {
                      setState(() {
                        selectedMealType = value!;
                      });
                    },
                    items: ["Desayuno", "Almuerzo", "Snack", "Cena"]
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                  ),
                  for (String food in ["Pizza", "Ensalada", "Pasta", "Pollo"])
                    ListTile(
                      title: Text(food),
                      onTap: () {
                        addFoodToUser(day, selectedMealType, food);
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrar Planes Alimenticios"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de búsqueda para filtrar usuarios por correo
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar usuario por correo',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
            const SizedBox(height: 16),
            
            // Lista de usuarios (no administradores)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('isAdmin', isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  final users = snapshot.data!.docs.where((doc) {
                    final userData = doc.data() as Map<String, dynamic>;
                    final email = (userData['email'] ?? '').toString().toLowerCase();
                    return _searchQuery.isEmpty || email.contains(_searchQuery);
                  }).toList();
                  
                  if (users.isEmpty) {
                    return const Center(
                      child: Text('No se encontraron usuarios con ese correo'),
                    );
                  }
                  
                  // Vista dividida: lista de usuarios a la izquierda, detalles a la derecha
                  return Row(
                    children: [
                      // Lista de usuarios (1/3 del ancho)
                      Expanded(
                        flex: 1,
                        child: Card(
                          elevation: 4,
                          child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final userData = users[index].data() as Map<String, dynamic>;
                              final userId = users[index].id;
                              final name = userData['name'] ?? 'Sin nombre';
                              final email = userData['email'] ?? 'Sin correo';
                              
                              return ListTile(
                                title: Text(name),
                                subtitle: Text(email),
                                selected: selectedUserId == userId,
                                selectedTileColor: Colors.blue.shade100,
                                onTap: () {
                                  setState(() {
                                    selectedUserId = userId;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Detalles del plan alimenticio (2/3 del ancho)
                      Expanded(
                        flex: 2,
                        child: selectedUserId != null
                            ? _buildFoodPlanView()
                            : const Center(
                                child: Text(
                                  'Selecciona un usuario para ver su plan alimenticio',
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodPlanView() {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          // Información del usuario seleccionado
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(selectedUserId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                );
              }
              
              final userData = snapshot.data!.data() as Map<String, dynamic>?;
              final name = userData?['name'] ?? 'Usuario';
              final email = userData?['email'] ?? 'Sin correo';
              
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    if (userData?['weight'] != null && userData?['height'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Peso: ${userData!['weight']} kg | Altura: ${userData['height']} cm',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    const Divider(height: 24),
                  ],
                ),
              );
            },
          ),
          
          // Plan alimenticio
          Expanded(
            child: ListView.builder(
              itemCount: daysOfWeek.length,
              itemBuilder: (context, index) {
                final day = daysOfWeek[index];
                // Formato más legible para la fecha
                final dateComponents = day.split('-');
                final formattedDay = '${dateComponents[2]}/${dateComponents[1]}/${dateComponents[0]}';
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ExpansionTile(
                    title: Text(
                      formattedDay,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(selectedUserId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          
                          final userData = snapshot.data!.data() as Map<String, dynamic>?;
                          final meals = userData?['meals'] ?? {};
                          
                          return Column(
                            children: [
                              for (String mealType in [
                                "Desayuno",
                                "Almuerzo",
                                "Snack",
                                "Cena"
                              ])
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16, top: 8),
                                      child: Text(
                                        mealType.toUpperCase(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (meals[day] != null &&
                                        meals[day][mealType] != null)
                                      for (String meal in List<String>.from(
                                          meals[day][mealType]))
                                        ListTile(
                                          leading: const Icon(Icons.restaurant),
                                          title: Text(meal),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () async {
                                              // Eliminar comida
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(selectedUserId)
                                                  .update({
                                                'meals.$day.$mealType': FieldValue.arrayRemove([meal])
                                              });
                                            },
                                          ),
                                        ),
                                  ],
                                ),
                              
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ElevatedButton.icon(
                                  onPressed: () => showFoodSelectionDialog(day),
                                  icon: const Icon(Icons.add),
                                  label: const Text("Añadir Plato"),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}