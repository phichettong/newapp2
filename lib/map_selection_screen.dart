import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapSelectionScreen extends StatefulWidget {
  @override
  _MapSelectionScreenState createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  late GoogleMapController mapController;
  LatLng _selectedLocation = LatLng(13.7563, 100.5018);
  String _address = "Select Location on Map"; // ค่าที่อยู่เริ่มต้น
  TextEditingController _searchController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
      _getAddressFromLatLng(position);
    });
  }

  void _confirmSelection() {
    Navigator.pop(context, _address);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        // ปรับรูปแบบที่อยู่
        _address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _searchAddress() async {
    List<Location> locations = await locationFromAddress(_searchController.text);
    if (locations.isNotEmpty) {
      final LatLng newLocation = LatLng(locations.first.latitude, locations.first.longitude);
      mapController.animateCamera(CameraUpdate.newLatLng(newLocation));
      setState(() {
        _selectedLocation = newLocation;
        _getAddressFromLatLng(newLocation); // อัปเดตที่อยู่ตามตำแหน่งใหม่
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _confirmSelection,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Address',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                _searchAddress();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _address, // แสดงที่อยู่ที่ปักหมุด
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('selected-location'),
                  position: _selectedLocation,
                ),
              },
              onTap: _onTap,
            ),
          ),
        ],
      ),
    );
  }
}
