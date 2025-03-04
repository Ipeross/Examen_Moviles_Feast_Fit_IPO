import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:feast_fit/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const CustomAppBar2(
          title: 'Bienvenido a FeastFit',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Explora recetas saludables y personaliza tu plan de alimentación.',
                  style: TextStyle(fontSize: 16, color: theme.colorScheme.onSurface.withOpacity(0.6)),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _buildFeaturedRecipe(context),
                      const SizedBox(height: 20),
                      _buildRecommendedRecipes(context),
                      const SizedBox(height: 20),
                      _buildDailyPlan(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedRecipe(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/cesar.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [theme.primaryColorDark.withOpacity(0.6), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Receta Destacada: Ensalada Cesar',
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedRecipes(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recomendaciones',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildRecipeCard(context, 'Smoothie de Fresa', 'assets/smoothie.jpg'),
              _buildRecipeCard(context, 'Avena con Frutas', 'assets/oatmeal.jpg'),
              _buildRecipeCard(context, 'Tostadas con Aguacate', 'assets/aguacate.jpg'),
            ],
          ),
        ),
      ],
    );
  }

 Future<List<String>> _loadAssetImages() async {
    // Cargar todas las imágenes de la carpeta assets
    final List<String> imagePaths = [];
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // Filtrar las imágenes que están en la carpeta assets
    manifestMap.forEach((key, value) {
      if (key.startsWith('assets/') && (key.endsWith('.jpg') || key.endsWith('.png'))) {
        imagePaths.add(key);
      }
    });

    return imagePaths;
  }

  Widget _buildDailyPlan(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser ?.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Text('Error al cargar el plan del día');
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('No se encontró información del plan del día');
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final meals = userData['meals'] as Map<String, dynamic>? ?? {};
        final dayMeals = meals[formattedDate] as Map<String, dynamic>? ?? {};

        if (dayMeals.isEmpty) {
          return const Center(
            child: Text(
              'NO HAY COMIDA HOY',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 85, 54, 29),
              ),
            ),
          );
        }

        return FutureBuilder<List<String>>(
          future: _loadAssetImages(),
          builder: (context, imageSnapshot) {
            if (imageSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (imageSnapshot.hasError) {
              return const Text('Error al cargar las imágenes');
            }

            final imagePaths = imageSnapshot.data ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plan del Día',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dayMeals.length,
                    itemBuilder: (context, index) {
                      final mealType = dayMeals.keys.elementAt(index);
                      final foodList = dayMeals[mealType] as List<dynamic>? ?? [];
                      
                      final randomImage = (imagePaths.isNotEmpty) ? imagePaths[index % imagePaths.length] : 'assets/carbonara.jpg';

                      return _buildRecipeCard(
                        context,
                        '$mealType: ${foodList.join(", ")}',
                        randomImage,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildRecipeCard(BuildContext context, String title, String imagePath) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.primaryColorDark.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
