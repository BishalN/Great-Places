import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helper/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocaion =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocaion == null) {
      return;
    }

    ///
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
              border:
                  Border.all(width: 1.5, color: Theme.of(context).accentColor)),
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text(
                  'No Place Chose',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: _getUserLocation,
                icon: Icon(Icons.location_on),
                label: FittedBox(child: Text('Current Location')),
                textColor: Theme.of(context).primaryColor,
              ),
              FlatButton.icon(
                onPressed: _selectOnMap,
                icon: Icon(Icons.location_on),
                label: Text('choose location on map'),
                textColor: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ],
    );
  }
}
