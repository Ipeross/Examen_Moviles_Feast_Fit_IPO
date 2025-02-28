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

  @override
  void initState() {
    super.initState();
    daysOfWeek = getDaysOfWeek();
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
    showDialog(
      context: context,
      builder: (context) {
        String selectedMealType = "Desayuno";
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('isAdmin', isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              final users = snapshot.data!.docs;
              return DropdownButton<String>(
                value: selectedUserId,
                hint: const Text("Selecciona un usuario"),
                onChanged: (newUserId) {
                  setState(() {
                    selectedUserId = newUserId;
                  });
                },
                items: users.map((user) {
                  return DropdownMenuItem(
                    value: user.id,
                    child: Text(user.data()?['name'] ?? 'Sin nombre'),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 10),
          if (selectedUserId != null)
            Expanded(
              child: ListView.builder(
                itemCount: daysOfWeek.length,
                itemBuilder: (context, index) {
                  final day = daysOfWeek[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ExpansionTile(
                      title: Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(selectedUserId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return const CircularProgressIndicator();
                            final userData = snapshot.data!.data();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(mealType.toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      if (meals[day] != null &&
                                          meals[day][mealType] != null)
                                        for (String meal in List<String>.from(
                                            meals[day][mealType]))
                                          ListTile(title: Text(meal)),
                                    ],
                                  ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () => showFoodSelectionDialog(day),
                                    child: const Text("Añadir Plato"),
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
