import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorForm extends StatefulWidget {
  @override
  _DonorFormState createState() => _DonorFormState();
}

class _DonorFormState extends State<DonorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _lastDonorDateController = TextEditingController();
  String _selectedBloodGroup = 'A+';

  // List of blood groups
  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Donor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastDonorDateController,
                decoration: const InputDecoration(labelText: 'Last Donor Date'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last donor date';
                  }
                  return null;
                },
              ),


              
              DropdownButtonFormField(
                value: _selectedBloodGroup,
                items: bloodGroups.map((bloodGroup) {
                  return DropdownMenuItem(
                    value: bloodGroup,
                    child: Text(bloodGroup),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBloodGroup = value.toString();
                  });
                },
                decoration: const InputDecoration(labelText: 'Blood Group'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save data to Firebase
                    addDonorToFirebase();
                  }
                },
                child: const Text('Add Donor'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addDonorToFirebase() {
    // Create a map of donor data
    Map<String, dynamic> donorData = {
      'name': _nameController.text,
      'city': _cityController.text,
      'phone': _phoneController.text,
      'lastDonorDate': _lastDonorDateController.text,
      'bloodGroup': _selectedBloodGroup,
    };

    // Add the data to the "donor-data" collection in Firebase
    FirebaseFirestore.instance.collection('donor-data').add(donorData).then((value) {
      print('Donor data added to Firebase');
      // Clear form fields after data is successfully added
      _nameController.clear();
      _cityController.clear();
      _phoneController.clear();
      _lastDonorDateController.clear();
      setState(() {
        _selectedBloodGroup = 'A+';
      });
    }).catchError((error) {
      print('Error adding donor data: $error');
    });
  }
}


