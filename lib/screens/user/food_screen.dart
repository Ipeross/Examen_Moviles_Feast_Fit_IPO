import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final List<String> _daysOfWeek = [];
  final Map<String, String> _mealTypeImages = {
    'Desayuno': 'assets/breakfast.jpg',
    'Almuerzo': 'assets/lunch.jpg',
    'Snack': 'assets/snack.jpg',
    'Cena': 'assets/dinner.jpg',
  };
  
  final String _defaultFoodImage = 'assets/carbonara.jpg';
  
  final Map<String, String> _foodImages = {
    'Pizza': 'assets/pizza.jpg',
    'Ensalada': 'assets/ensalada.jpg',
    'Pasta': 'assets/carbonara.jpg',
    'Pollo': 'assets/pollo.jpg',
  };

  @override
  void initState() {
    super.initState();
    _generateDaysOfWeek();
  }
  
  void _generateDaysOfWeek() {
    final now = DateTime.now();
    _daysOfWeek.clear();
    for (int i = 0; i < 7; i++) {
      final day = now.add(Duration(days: i));
      final formattedDate = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
      _daysOfWeek.add(formattedDate);
    }
  }
  
  String _formatDate(String isoDate) {
    final parts = isoDate.split('-');
    if (parts.length != 3) return isoDate;
    
    try {
      final date = DateTime(
        int.parse(parts[0]), 
        int.parse(parts[1]), 
        int.parse(parts[2])
      );
      
      const monthNames = [
        'ene.', 'feb.', 'mar.', 'abr.', 'may.', 'jun.',
        'jul.', 'ago.', 'sept.', 'oct.', 'nov.', 'dic.'
      ];
      
      return "${date.day} ${monthNames[date.month - 1]} ${date.year}";
    } catch (e) {
      return isoDate;
    }
  }

  String _getFoodImage(String foodName) {
    return _foodImages[foodName] ?? _defaultFoodImage;
  }
  
  String _getMealTypeImage(String mealType) {
    return _mealTypeImages[mealType] ?? _defaultFoodImage;
  }
  
  String _estimateCalories(String foodName) {
    final caloriesMap = {
      'Pizza': '800 calorías',
      'Ensalada': '350 calorías',
      'Pasta': '650 calorías',
      'Pollo': '500 calorías',
    };
    
    return caloriesMap[foodName] ?? '400 calorías';
  }

  String _generateDescription(String foodName) {
    final descriptions = {
      'Pizza': 'Pizza con queso mozzarella, tomate y albahaca',
      'Ensalada': 'Mezcla de verduras frescas con vinagreta',
      'Pasta': 'Pasta con salsa cremosa, huevo, panceta y queso parmesano',
      'Pollo': 'Pollo a la parrilla con especias y limón',
    };
    
    return descriptions[foodName] ?? 'Plato nutritivo preparado con ingredientes frescos';
  }

  Widget _buildFoodItem(BuildContext context, String foodName, String mealType) {
    final imageUrl = _getFoodImage(foodName);
    final calories = _estimateCalories(foodName);
    final description = _generateDescription(foodName);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodDetailScreen(
                foodName: foodName,
                imageUrl: imageUrl,
                description: description,
                calories: calories,
                mealType: mealType,
              ),
            ),
          );
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: SizedBox(
                  width: 100,
                  height: double.infinity,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        _defaultFoodImage,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        foodName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              calories,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              mealType,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildMealTypeSection(String dayKey, String mealType, List<String> foods) {
    if (foods.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
          child: Text(
            mealType,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
        ),
        ...foods.map((food) => _buildFoodItem(context, food, mealType)).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Error al cargar tu plan de comidas',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }
          
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('No se encontró información de tu plan alimenticio'),
            );
          }
          
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final meals = userData['meals'] as Map<String, dynamic>? ?? {};
          
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/carbonara.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 20,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tu Plan de',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Alimentación',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _daysOfWeek.length,
                    itemBuilder: (context, index) {
                      final day = _daysOfWeek[index];
                      final formattedDay = _formatDate(day);
                      
                      return Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          title: Text(
                            formattedDay,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          children: [
                            if (meals.containsKey(day))
                              ...["Desayuno", "Almuerzo", "Snack", "Cena"].map((mealType) {
                                final mealData = meals[day] as Map<String, dynamic>? ?? {};
                                final foodList = mealData[mealType] as List<dynamic>? ?? [];
                                return _buildMealTypeSection(
                                  day,
                                  mealType,
                                  foodList.cast<String>(),
                                );
                              }).toList()
                            else
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'No hay comidas programadas para este día',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
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
        },
      ),
    );
  }
}

class FoodDetailScreen extends StatelessWidget {
  final String foodName;
  final String imageUrl;
  final String description;
  final String calories;
  final String mealType;
  
  const FoodDetailScreen({
    super.key, 
    required this.foodName, 
    required this.imageUrl, 
    required this.description, 
    required this.calories,
    required this.mealType,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodName),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 220,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/carbonara.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          foodName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          mealType,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      calories,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  const Text(
                    'Información Nutricional',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildNutritionInfo(),
                  
                  const SizedBox(height: 24),
                  const Text(
                    'Ingredientes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildIngredientsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNutritionInfo() {
    return Column(
      children: [
        _buildNutritionRow('Calorías', calories),
        _buildNutritionRow('Proteínas', '25g'),
        _buildNutritionRow('Carbohidratos', '48g'),
        _buildNutritionRow('Grasas', '18g'),
        _buildNutritionRow('Fibra', '5g'),
      ],
    );
  }
  
  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildIngredientsList() {
    final ingredients = [
      'Ingrediente 1 - 100g',
      'Ingrediente 2 - 50g',
      'Ingrediente 3 - 75g',
      'Ingrediente 4 - 30g',
      'Ingrediente 5 - 10g',
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredients.map((ingredient) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              const Icon(Icons.circle, size: 8, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                ingredient,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}