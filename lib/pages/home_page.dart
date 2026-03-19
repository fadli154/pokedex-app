import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_flutter/models/pokemon_model.dart';
import 'package:package_flutter/partials/drawer.dart';
import 'package:package_flutter/partials/navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future getAllPokemon() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=15'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          await json.decode(response.body) as Map<String, dynamic>;

      final List<Map<String, dynamic>> results =
          List<Map<String, dynamic>>.from(data['results']);

      return results.map((e) => Pokemon.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Basic Gradient AppBar example
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Pokemon App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent, // Required
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.amber],
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: FutureBuilder(
        future: getAllPokemon(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final allPokemon = snapshot.data ?? [];

          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 30),
            itemCount: allPokemon.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: .8, // 🔥 coba kecilin
            ),
            itemBuilder: (context, index) {
              final pokemon = allPokemon[index];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(pokemon.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(pokemon.name),
                  ),
                ],
              );
            },
          );
        },
      ),

      bottomNavigationBar: MyNavigationBar(),

      drawer: MyDrawer(),
    );
  }
}
