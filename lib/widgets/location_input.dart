import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LoactionInputState();
  }
}

class _LoactionInputState extends State<LocationInput> {
  Location? _pickedLocation;
  var _isGettingLocation = false;
  void getCurrentLocation() async {

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
    _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    setState(() {
    _isGettingLocation = false;
    });

    print(locationData.latitude);
    print(locationData.longitude);
  }

  @override
  Widget build(BuildContext context) {

    Widget previewContent = Text(
            'No Location Choosen',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          );

    if(_isGettingLocation){
      previewContent = const CircularProgressIndicator();
    }      
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              label: const Text('Get current Location'),
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_on_outlined),
            ),
            TextButton.icon(
              label: const Text('Select on Map'),
              onPressed: () {},
              icon: const Icon(Icons.map_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
