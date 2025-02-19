import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news/admin/application/news_cubit.dart';
import 'package:news/admin/application/news_state.dart';
import 'package:news/admin/domain/admin_model.dart';
import 'dart:io'; // For File handling
import 'package:news/features/auth/presentation/login/sign_in_form.dart'; // Assuming you have a login screen

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _shortDescriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _selectedDate;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Function to generate random latitude and longitude
  double _generateRandomLatitude() {
    Random random = Random();
    return random.nextDouble() * 180 - 90; // Range: -90 to 90
  }

  double _generateRandomLongitude() {
    Random random = Random();
    return random.nextDouble() * 360 - 180; // Range: -180 to 180
  }

  // Submit function to save data
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final news = NewsModel(
        title: _titleController.text,
        description: _descriptionController.text,
        shortDescription: _shortDescriptionController.text,
        time: _selectedDate ?? DateTime.now(),
        location: _locationController.text,
        latitude: _generateRandomLatitude(),  // Random Latitude
        longitude: _generateRandomLongitude(),  // Random Longitude
        imageUrl: _selectedImage?.path, // Image Path (use this if uploading image locally)
      );

      BlocProvider.of<NewsCubit>(context).addNews(news);
    }
  }

  // Image picker method to allow the user to pick an image
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // Logout function
  void _logout() {
    // Handle logout logic here (e.g., clearing user session or token)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInForm()), // Redirect to LoginScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel - Add News'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is NewsAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('News added successfully!')));
          } else if (state is NewsError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title Field
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Description Field
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Short Description Field
                    TextFormField(
                      controller: _shortDescriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Short Description',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a short description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Time Field (Date Picker)
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: TextEditingController(
                            text: _selectedDate == null
                                ? ''
                                : '${_selectedDate?.toLocal()}'.split(' ')[0],
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Time',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select the date';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Location Field
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Image Picker Button
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: const Text('Pick an Image'),
                    ),
                    const SizedBox(height: 10),

                    // Display selected image
                    if (_selectedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _selectedImage!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.greenAccent,
                      ),
                      child: state is NewsLoading
                          ? const CircularProgressIndicator()
                          : const Text('Add News'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
