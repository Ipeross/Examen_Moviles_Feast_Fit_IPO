import 'package:feast_fit/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
      ]
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

  Widget _buildDailyPlan(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, String>> meals = [
      {'name': 'Desayuno', 'image': 'assets/oatmeal.jpg'},
      {'name': 'Almuerzo', 'image': 'assets/oatmeal.jpg'},
      {'name': 'Cena', 'image': 'assets/oatmeal.jpg'},
      {'name': 'Snack', 'image': 'assets/oatmeal.jpg'},
    ];

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
            itemCount: meals.length,
            itemBuilder: (context, index) {
              return _buildRecipeCard(
                context,
                meals[index]['name']!,
                meals[index]['image']!
              );
            },
          ),
        ),
      ],
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