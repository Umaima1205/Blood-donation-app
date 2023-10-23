import 'package:Zindgi/utility/App_Colors.dart';
import 'package:Zindgi/utility/App_Colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserDonorForm extends StatefulWidget {
  @override
  _UserDonorFormState createState() => _UserDonorFormState();
}

class _UserDonorFormState extends State<UserDonorForm> {
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
        backgroundColor: AppColors.RedColor,
        title: const Text(
          "Zindgi",
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 2,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
       
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _lastDonorDateController,
                decoration: const InputDecoration(
                  labelText: 'Last Donor Date',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last donor date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
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
                decoration: const InputDecoration(
                  labelText: 'Blood Group',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save data to Firebase
                      addUserDonorToFirebase();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.RedColor),
                  ),
                  child: const Text('Become A Donor'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addUserDonorToFirebase() {
    // Create a map of donor data
    Map<String, dynamic> donorData = {
      'name': _nameController.text,
      'city': _cityController.text,
      'phone': _phoneController.text,
      'lastDonorDate': _lastDonorDateController.text,
      'bloodGroup': _selectedBloodGroup,
    };

    // Add the data to the "donor-data" collection in Firebase
    FirebaseFirestore.instance.collection('user-donor-data').add(donorData).then((value) {
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
