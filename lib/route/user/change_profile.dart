import 'dart:async';
import 'dart:developer';
import 'package:aastu_ecsf/widget/my_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/widget/my_text.dart';
import 'package:firebase_database/firebase_database.dart';

class ChangeProfileDialog extends StatefulWidget {
  const ChangeProfileDialog({Key? key}) : super(key: key);

  @override
  ChangeProfileDialogState createState() => ChangeProfileDialogState();
}

class ChangeProfileDialogState extends State<ChangeProfileDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  String? selectedTeam;
  String photoUrl = "assets/images/user.png"; // Initialize with null
  String name = '';
  String bio = '';
  String role = '';
  String department = '';
  String batch = '';
  String team = '';
  String email = '';
  String joinedDate = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void> fetchData() async {
    log("ProfileRouteState: fetchData() called");
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final ref = FirebaseDatabase.instance.ref();
    log("User ID: $userId");
    final snapshot = await ref.child('users/$userId').get();
    final Map<dynamic, dynamic>? data =
        snapshot.value as Map<dynamic, dynamic>?;

    if (snapshot.exists) {
      setState(() {
        name = data!['name'] ?? '';
        bio = data['bio'] ?? '';
        role = data['role'] ?? '';
        department = data['department'] ?? '';
        batch = data['batch'] ?? '';
        team = data['team'] ?? '';
        email = data['email'] ?? '';
        joinedDate =
            data['joinedDate'] ?? ''; // Update the photoUrl from the data
      });
      log("User Info${snapshot.value}");
      log("User ID: $userId");
    } else {
      log('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Material(
              color: const Color(0xff1F1F1F),
              child: SizedBox(
                height: 55,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Text(
                      "Change Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontFamily: "MyFont",
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      splashColor: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: const Text(
                          "SAVE",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: "MyBoldFont",
                            color: Color(0xffd1a552),
                          ),
                        ),
                      ),
                      onTap: () {
                        // Get the updated values from the text controllers
                        String updatedName = nameController.text.isNotEmpty
                            ? nameController.text
                            : name;
                        String updatedDepartment =
                            departmentController.text.isNotEmpty
                                ? departmentController.text
                                : department;
                        String updatedBio = bioController.text.isNotEmpty
                            ? bioController.text
                            : bio;
                        String updatedBatch = batchController.text.isNotEmpty
                            ? batchController.text
                            : batch;
                        String teamBatch = teamController.text.isNotEmpty
                            ? teamController.text
                            : team;

// Perform the update in the database
                        final userId = FirebaseAuth.instance.currentUser!.uid;
                        final ref =
                            FirebaseDatabase.instance.ref('users/$userId');

                        ref.update({
                          'name': updatedName,
                          'department': updatedDepartment,
                          'bio': updatedBio,
                          'batch': updatedBatch,
                          'team': teamBatch,
                        }).then((_) {
                          // Update successful
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            elevation: 0,
                            content: Card(
                              color: const Color(0xff212121),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 5, height: 0),
                                    Expanded(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Profile Updated",
                                            style: MyText.subhead(context)!
                                                .copyWith(
                                                    color: const Color.fromARGB(
                                                        255, 255, 147, 24))),
                                        Text("Your profile has been updated",
                                            style: MyText.caption(context)!
                                                .copyWith(
                                                    color: const Color.fromARGB(
                                                        255, 255, 249, 249))),
                                      ],
                                    )),
                                    Container(
                                        color: const Color.fromARGB(
                                            255, 116, 116, 116),
                                        height: 35,
                                        width: 1,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5)),
                                    SnackBarAction(
                                      label: "UNDO",
                                      textColor: const Color.fromARGB(
                                          255, 211, 211, 211),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              ),
                            ),
                            backgroundColor: Colors.transparent,
                            duration: const Duration(seconds: 1),
                          ));
                          Timer(const Duration(seconds: 3), () {
                            Navigator.of(context)
                                .pushReplacementNamed('/ProfileRoute');
                          });
                        }).catchError((error) {
                          // Update failed
                          log('Update failed: $error');
                          MyToast.show(
                              "Failed to update profile: $error", context);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey[300], height: 0, thickness: 0.5),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                      hintText: name,
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        fontFamily: "MyFont",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(height: 25),
                  TextField(
                    controller: departmentController,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: "Your department",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "MyFont",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(height: 25),
                  TextField(
                    controller: bioController,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: "Bio",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "MyFont",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(height: 25),
                  TextField(
                    controller: batchController,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: "Your Batch",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "MyFont",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(height: 25),
                  const Text(
                    "Your Fellowship Team",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "MyFont",
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          splashColor: Colors.grey,
                          child: DropdownButton<String>(
                            onChanged: (String? value) {
                              // Handle the selected value here
                              setState(() {
                                selectedTeam = value;
                                teamController.text = selectedTeam ?? '';
                              });
                            },
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'I4U',
                                child: Text('I4U Team'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Choir',
                                child: Text('Choir Team'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Outreach',
                                child: Text('Outreach Team'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Media',
                                child: Text('Media Team'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Natanims',
                                child: Text('Natanims Team'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Prayer',
                                child: Text('Prayer Team'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Counseling',
                                child: Text('Counseling Team'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Leaders',
                                child: Text('Main Leaders'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Others',
                                child: Text('Others'),
                              ),
// Add more DropdownMenuItem widgets as needed
                            ],
                            hint: const Text(
                              "Select Teams",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "MyFont",
                                color: Color.fromARGB(255, 201, 200, 200),
                              ),
                            ),
                            iconDisabledColor:
                                const Color.fromARGB(255, 197, 197, 197),
                          ),
                          onTap: () {},
                        ),
                      ),
                      Container(width: 15),
                    ],
                  ),
                  Container(height: 25),
                ],
              ),
            ),
            Container(height: 20),
          ],
        ),
      ),
    );
  }
}
