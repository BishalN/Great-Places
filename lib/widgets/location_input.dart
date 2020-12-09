import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getUserLocation() async {
    final locData = await Location().getLocation();
    print(locData);
    print(locData.latitude);
    print(locData.accuracy);
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
                onPressed: () {},
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
