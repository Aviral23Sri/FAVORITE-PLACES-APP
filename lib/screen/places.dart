import 'package:favorite_places/screen/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() {
    return _PlacesListScreenState();
  }
}

class _PlacesListScreenState extends State<PlacesScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [IconButton(onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>const AddPlaceScreen()),);
        }, icon: const Icon(Icons.add))],
      ),
      body: PlacesList(places: [],), 
    );
  }
}
