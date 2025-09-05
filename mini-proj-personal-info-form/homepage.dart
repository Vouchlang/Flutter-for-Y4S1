import 'package:demo_app/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _firstNameController =
      TextEditingController();
  final TextEditingController _lastNameController =
      TextEditingController();
  final TextEditingController _ageController =
      TextEditingController();
  final TextEditingController _jobController =
      TextEditingController();
  final TextEditingController _hobbiesController =
      TextEditingController();

  // Other fields
  DateTime? _dob;
  String? _status;
  String? _gender;

  // Place of Birth
  String _placeOfBirth = 'Phnom Penh';
  final List<String> _places = [
    "Phnom Penh",
    "Siem Reap",
    "Battambang",
    "Kampot",
    "Takeo",
  ];

  // Current Address
  String _currentAddress = 'Phnom Penh';
  final List<String> _address = [
    "Phnom Penh",
    "Siem Reap",
    "Battambang",
    "Kampot",
    "Takeo",
  ];

  // Pick Date of Birth
  Future<void> _pickDOB() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (datePicked != null) {
      setState(() => _dob = datePicked);
    }
  }

  // Submmit Form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsetsGeometry.all(25),
              height: 200,
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Are you sure this is your personal info?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'No',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoScreen(
                                firstName:
                                    _firstNameController
                                        .text,
                                lastName:
                                    _lastNameController
                                        .text,
                                age: _ageController.text,
                                gender:
                                    _gender ?? 'Non Gender',
                                dob: _dob != null
                                    ? "Date of Birth: ${DateFormat('yyyy-MMM-dd').format(_dob!)}"
                                    : "Date of Birth: Not Selected",
                                pob: _placeOfBirth,
                                currenAddress:
                                    _currentAddress,
                                status: _status ?? 'No Job',
                                job: _jobController.text,
                                hobby:
                                    _hobbiesController.text,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Info Form"),
        backgroundColor: Colors.cyan[200],
        elevation: 5,
        shadowColor: Colors.grey[50],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            customField(
              controller: _firstNameController,
              inputType: TextInputType.text,
              label: 'First Name',
              validator: (value) => value.isEmpty
                  ? "Please enter your first name"
                  : null,
            ),
            const SizedBox(height: 15),
            customField(
              controller: _lastNameController,
              inputType: TextInputType.text,
              label: 'Last Name',
              validator: (value) => value.isEmpty
                  ? "Please enter your last name"
                  : null,
            ),
            const SizedBox(height: 15),
            customField(
              controller: _ageController,
              inputType: TextInputType.number,
              label: 'Age',
              validator: (value) => value.isEmpty
                  ? "Please enter your age"
                  : null,
            ),
            const SizedBox(height: 15),
            const Text("Gender:"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: ["Male", "Female", "Others"].map((
                status,
              ) {
                return Column(
                  children: [
                    Text(status),
                    Radio(
                      activeColor: Colors.green,
                      value: status,
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(
                          () => _gender = value.toString(),
                        );
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _dob != null
                        ? "Date of Birth: ${DateFormat('yyyy-MMM-dd').format(_dob!)}"
                        : "Date of Birth: Not Selected",
                  ),
                ),
                InkWell(
                  onTap: _pickDOB,
                  child: Card(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: const Text("Pick Date"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            customDropdown(
              label: 'Place of Birth',
              value: _placeOfBirth,
              items: _places.map((place) {
                return DropdownMenuItem(
                  value: place,
                  child: Text(place),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _placeOfBirth = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            customDropdown(
              label: 'Current Address',
              value: _currentAddress,
              items: _address.map((place) {
                return DropdownMenuItem(
                  value: place,
                  child: Text(
                    place,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _currentAddress = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            const Text("Status:"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: ["Single", "Married", "Divorced"]
                  .map((status) {
                    return Column(
                      children: [
                        Text(status),
                        Radio(
                          activeColor: Colors.green,
                          value: status,
                          groupValue: _status,
                          onChanged: (value) {
                            setState(() {
                              _status = value.toString();
                            });
                          },
                        ),
                      ],
                    );
                  })
                  .toList(),
            ),
            SizedBox(height: 20),
            customField(
              controller: _jobController,
              label: 'Job',
              inputType: TextInputType.text,
              validator: (value) => value.isEmpty
                  ? "Please enter your Job"
                  : null,
            ),
            const SizedBox(height: 15),
            customField(
              controller: _hobbiesController,
              label: 'Hobbies',
              inputType: TextInputType.text,
              validator: (value) => value.isEmpty
                  ? "Please enter your Hobbies"
                  : null,
            ),
            const SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: _submitForm,
                child: Card(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: const Text("Submit"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget customField({
  required final TextEditingController controller,
  required final String label,
  required final TextInputType inputType,
  required final FormFieldValidator validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.all(15),
    ),
    validator: validator,
  );
}

Widget customDropdown({
  required final String label,
  value,
  required final List<DropdownMenuItem<String>>? items,
  required final Function(String?)? onChanged,
}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1.2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.black54,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.all(15),
    ),
    icon: const Icon(Icons.location_on, color: Colors.red),
    value: value,
    items: items!,
    onChanged: onChanged!,
  );
}