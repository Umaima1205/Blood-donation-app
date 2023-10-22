import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zindgiapp/Screens/Donor_form.dart';
import 'package:zindgiapp/utility/App_Colors.dart';

import '../authentication/Methods.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.add_circled,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return DonorForm();
              }),
            );
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              logOut(context);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18.0),
              child: const Icon(
                CupertinoIcons.arrow_right_circle_fill,
                size: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donor-data').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final donors = snapshot.data!.docs;

          if (donors.isEmpty) {
            return Center(child: Text('No donors available.'));
          }

          return ListView.builder(
            itemCount: donors.length,
            itemBuilder: (context, index) {
              final donor = donors[index].data() as Map<String, dynamic>;
              return ListTile(
                onTap: () {
                  // Navigate to the edit page with donor details.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return EditDonorPage(donor: donor, documentId: donors[index].id);
                    }),
                  );
                },
                title: Text(donor['name']),
  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('City: ${donor['city']}'),
      Text('Phone: ${donor['phone']}'),
      Text('Last Donor Date: ${donor['lastDonorDate']}'),
    ],
  ),
                trailing: _buildBloodGroupBadge(donor['bloodGroup']),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBloodGroupBadge(String bloodGroup) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getBadgeColor(bloodGroup),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        bloodGroup,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Color _getBadgeColor(String bloodGroup) {
    // Customize the badge color based on the blood group if needed.
    // You can set specific colors for different blood groups.
    return Colors.red; // Change this color as needed.
  }
}

class EditDonorPage extends StatefulWidget {
  final Map<String, dynamic> donor;
  final String documentId;

  EditDonorPage({required this.donor, required this.documentId});

  @override
  _EditDonorPageState createState() => _EditDonorPageState();
}

class _EditDonorPageState extends State<EditDonorPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.donor['name'];
    cityController.text = widget.donor['city'];
    phoneController.text = widget.donor['phone'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Donor'),
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
    FirebaseFirestore.instance.collection('donor-data').doc(widget.documentId).update({
      'name': nameController.text,
      'city': cityController.text,
      'phone': phoneController.text,
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
