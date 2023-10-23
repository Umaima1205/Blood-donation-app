
import 'package:Zindgi/screens/login.dart';
import 'package:Zindgi/utility/App_Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'donor_form.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
  
}

class _HomeViewState extends State<HomeView> {
  
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
  key: _scaffoldKey,
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
  drawer: Drawer(
    child: ListView(
      children: <Widget>[
       const DrawerHeader(
  decoration: BoxDecoration(
    color: AppColors.RedColor,
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Zindgi',
        style: TextStyle(
          color: Colors.white,

          fontSize: 30,
        ),
      ),
      Text(
        'Manager',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ],
  ),
),

        ListTile(
          title: const Text('Add Donor'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return DonorForm();
              }),
            );
          },
        ),
        ListTile(
          title: const Text('Edit Donor'),
          onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return EditDonorPage(documentId: '', donor: {},);
              }),
            );
          },
        ),
        ListTile(
          title: const Text('Delete Donor'),
          onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return EditDonorPage(documentId: '', donor: {},);
              }),
            );
          },
        ),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            logout(context);
          },
        ),
      ],
    ),
  ),
  // Add your ListView or other content here

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donor-data').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final donors = snapshot.data!.docs;

          if (donors.isEmpty) {
            return const Center(child: Text('No donors available.'));
          }

      return ListView.builder(
  itemCount: donors.length,
  itemBuilder: (context, index) {
    final donor = donors[index].data() as Map<String, dynamic>;
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: AppColors.RedColor,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16), 
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return EditDonorPage(donor: donor, documentId: donors[index].id);
            }),
          );
        },
        title: Text(
          donor['name'],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'City: ${donor['city']}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Phone: ${donor['phone']}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        trailing: _buildBloodGroupBadge(donor['bloodGroup']),
      ),
    );
  },
);



        },
      ),
    );
  }

  Widget _buildBloodGroupBadge(String bloodGroup) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getBadgeColor(bloodGroup),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        bloodGroup,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Color _getBadgeColor(String bloodGroup) {
  
    return Colors.red; 
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
    final TextEditingController lastDonorDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String _selectedBloodGroup = 'A+';

  // List of blood groups
  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  @override
  void initState() {
    super.initState();
    nameController.text = widget.donor['name'];
    cityController.text = widget.donor['city'];
    phoneController.text = widget.donor['phone'];
    lastDonorDateController.text = widget.donor['lastDonorDate'];
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.RedColor,
        title: const Text(
          "Edit Donor",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.RedColor), // Modify focused color
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.RedColor), // Modify focused color
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.RedColor), // Modify focused color
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: lastDonorDateController,
                  decoration: const InputDecoration(
                    labelText: 'LastDonorDate',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.RedColor), // Modify focused color
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
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
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.RedColor), // Modify focused color
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity, // Button width to fill the screen
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate and save the updated donor details.
                      if (_formKey.currentState!.validate()) {
                        // Update the donor details in Firestore.
                        updateDonorDetails();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.RedColor),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity, // Button width to fill the screen
                  child: ElevatedButton(
                    onPressed: () {
                      // Show a confirmation dialog before deleting the donor.
                      showDeleteConfirmationDialog(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red), // Use red color for the delete button
                      padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                    ),
                    child: const Text(
                      'Delete Donor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Donor details updated successfully.'),
      ));
    }).catchError((error) {
      // Handle error.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error updating donor details: $error'),
      ));
    });
  }

  void deleteDonor() {
    // Delete the donor from Firestore.
    FirebaseFirestore.instance.collection('donor-data').doc(widget.documentId).delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Donor deleted successfully.'),
      ));
      // After deletion, navigate back to the previous screen.
      Navigator.pop(context);
    }).catchError((error) {
      // Handle error.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error deleting donor: $error'),
      ));
    });
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this donor?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteDonor(); // Delete the donor
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}


  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

