import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_registration/controller/api_controller.dart';
import 'package:student_registration/view/login_page/login_widgets/content_background.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ApiController apiController = ApiController();
  TextEditingController nameController = TextEditingController();
  TextEditingController guardianController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode guardianFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode contactFocus = FocusNode();
  FocusNode whatsappFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  String academicYear = '2021-2022', className = 'Science', classId = '17529';
  File? image;
  bool loading = false;
  List<String> academicYearList = [
    '2020-2021',
    '2021-2022',
    '2022-2023',
    '2023-2024'
  ];
  List<String> classNameList = ['Science', 'Commerce', 'Humanities'];
  List<String> classIdList = ['17529', '17530', '17531'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Student Registration',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Academic Year',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: SizedBox(
                          width: double.infinity,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: academicYear,
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              onChanged: (String? value) {
                                setState(() => academicYear = value!);
                              },
                              items: academicYearList
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Class/Semester',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: SizedBox(
                          width: double.infinity,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: className,
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              onChanged: (String? value) {
                                setState(() => className = value!);
                              },
                              items: classNameList
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Student Name',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Enter name',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.name,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(guardianFocus),
                          validator: (value) {
                            if (value == '') return 'Name is empty';
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Guardian Name',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: TextFormField(
                          controller: guardianController,
                          focusNode: guardianFocus,
                          decoration: InputDecoration(
                            hintText: 'Enter guardian name',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.name,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(emailFocus),
                          validator: (value) {
                            if (value == '') return 'Guardian name is empty';
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: TextFormField(
                          controller: emailController,
                          focusNode: emailFocus,
                          decoration: InputDecoration(
                            hintText: 'Enter email address',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(contactFocus),
                          validator: (value) {
                            if (value == '') {
                              return 'Email is empty';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value!)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Contact Number',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: TextFormField(
                          controller: contactController,
                          focusNode: contactFocus,
                          decoration: InputDecoration(
                            hintText: 'Enter number',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.phone,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(whatsappFocus),
                          validator: (value) {
                            if (value == '') {
                              return 'Contact number is empty';
                            } else if (value!.length < 10) {
                              return 'Enter a valid mobile number';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'WhatsApp Number',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: TextFormField(
                          controller: whatsappController,
                          focusNode: whatsappFocus,
                          decoration: InputDecoration(
                            hintText: 'Enter number',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.phone,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(addressFocus),
                          validator: (value) {
                            if (value == '') {
                              return 'WhatsApp number is empty';
                            } else if (value!.length < 10) {
                              return 'Enter a valid mobile number';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: TextFormField(
                          controller: addressController,
                          focusNode: addressFocus,
                          decoration: InputDecoration(
                            hintText: 'Enter address',
                            border: InputBorder.none,
                          ),
                          maxLines: 5,
                          keyboardType: TextInputType.streetAddress,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          onFieldSubmitted: (value) =>
                              FocusScope.of(context).unfocus(),
                          validator: (value) {
                            if (value == '') return 'Address is empty';
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Image',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                XFile? pickedImage = await picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  image = pickedImage != null
                                      ? File(pickedImage.path)
                                      : null;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text('Choose File'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              image != null ? 'Image' : 'No file chosen',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.red.shade50,
                  child: Center(
                    child: Text(
                      'Student Login',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: TextFormField(
                          controller: usernameController,
                          focusNode: usernameFocus,
                          decoration: InputDecoration(
                            hintText: 'Enter username',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          onFieldSubmitted: (value) => FocusScope.of(context)
                              .requestFocus(passwordFocus),
                          validator: (value) {
                            if (value == '') {
                              return 'Username is empty';
                            } else if (!RegExp(r'^[a-zA-Z0-9_]+$')
                                .hasMatch(value!)) {
                              return 'Username can only contain letters, numbers, and underscores';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: TextFormField(
                          controller: passwordController,
                          focusNode: passwordFocus,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          onFieldSubmitted: (value) => FocusScope.of(context)
                              .requestFocus(confirmPasswordFocus),
                          validator: (value) {
                            if (value == '') {
                              return 'Password is empty';
                            } else if (value!.length < 6) {
                              return 'Password must contain at-least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Confirm Password',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ContentBackground(
                        content: TextFormField(
                          controller: confirmPasswordController,
                          focusNode: confirmPasswordFocus,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            border: InputBorder.none,
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          onFieldSubmitted: (value) =>
                              FocusScope.of(context).unfocus(),
                          validator: (value) {
                            if (value == '') {
                              return 'Enter your password again';
                            } else if (passwordController.text != value) {
                              return 'Password doesn\'t match';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                loading
                    ? SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurpleAccent,
                          strokeCap: StrokeCap.round,
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          bool apiSuccess = true;
                          if (formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            for (int i = 0; i < classNameList.length; i++) {
                              if (className == classNameList[i])
                                classId = classIdList[i];
                            }
                            apiSuccess = await apiController.getAcademicYear();
                            if (apiSuccess) {
                              apiSuccess = await apiController
                                  .getClassDetails(academicYear);
                              if (apiSuccess) {
                                apiSuccess = await apiController.saveUser(
                                  classId,
                                  nameController.text.trim(),
                                  usernameController.text.trim().toLowerCase(),
                                  addressController.text.trim(),
                                  emailController.text.trim(),
                                  contactController.text.trim(),
                                  whatsappController.text.trim(),
                                  image?.path.toString() ?? '',
                                  confirmPasswordController.text.trim(),
                                );
                              }
                            }
                          }
                          if (apiSuccess) {
                            setState(() {
                              nameController.clear();
                              guardianController.clear();
                              emailController.clear();
                              contactController.clear();
                              whatsappController.clear();
                              addressController.clear();
                              usernameController.clear();
                              passwordController.clear();
                              confirmPasswordController.clear();
                              image = null;
                              academicYear = '2021-2022';
                              className = 'Science';
                              classId = '17529';
                              loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Student data saved'),
                              ),
                            );
                          } else {
                            setState(() {
                              loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Unable to save student data'),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
