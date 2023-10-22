import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorDetailsPage extends StatefulWidget {
  final DocumentSnapshot donor; // Use DocumentSnapshot here

  DonorDetailsPage({required this.donor});

  @override
  _DonorDetailsPageState createState() => _DonorDetailsPageState();
}

class _DonorDetailsPageState extends State<DonorDetailsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController lastDonorDateController = TextEditingController(); // Add lastDonorDate controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.donor['name'];
    cityController.text = widget.donor['city'];
    phoneController.text = widget.donor['phone'];
    lastDonorDateController.text = widget.donor['lastDonorDate']; // Initialize lastDonorDate controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: lastDonorDateController, // Add lastDonorDate controller to the form
                decoration: InputDecoration(labelText: 'Last Donor Date'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validate and save the updated donor details.
                  if (_formKey.currentState!.validate()) {
                    // Update the donor details in Firestore.
                    updateDonorDetails();
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateDonorDetails() {
    // Update the donor details in Firestore with the new values from the text fields.
    FirebaseFirestore.instance.collection('donor-data').doc(widget.donor.id).update({
      'name': nameController.text,
      'city': cityController.text,
      'phone': phoneController.text,
      'lastDonorDate': lastDonorDateController.text, // Update the lastDonorDate field
    }).then((value) {
      // Successful update.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Donor details updated successfully.'),
      ));
    }).catchError((error) {
      // Handle error.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error updating donor details: $error'),
      ));
    });
  }
}
