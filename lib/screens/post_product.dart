// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:nidful/constant/constants.dart';
import 'package:nidful/models/user.dart' as model;
import 'package:nidful/providers/user_provider.dart';
import 'package:nidful/resources/firestore_methods.dart';
import 'package:nidful/screens/explore_page.dart';
import 'package:nidful/screens/profile_page.dart';
import 'package:nidful/utils/utils.dart';
import 'package:nidful/widgets/color_button.dart';
import 'package:nidful/widgets/input_field.dart';
import 'package:provider/provider.dart';

class PostProduct extends StatefulWidget {
  const PostProduct({Key? key}) : super(key: key);

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  // Initial Selected Value
  String dropdownvalue = 'Please Select Category';

  var selectedItem;

  // List of items in our dropdown menu
  var items = [
    'Please Select Category',
    'Electronics',
    'Digital',
    'Furniture',
    'Normal',
  ];
  Uint8List? _file;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;
  var _load = '';

  void postProduct(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_titleController.text.isEmpty ||
          _categoryController.text.isEmpty ||
          _conditionController.text.isEmpty ||
          _quantityController.text.isEmpty ||
          _descriptionController.text.isEmpty ||
          _file == null) {
        Get.snackbar(
          'Error',
          'Please fill all the fields',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
        );
        setState(() {
          _isLoading = false;
        });
      }
      String res = await FireStoreMethods().uploadPost(
        _titleController.text,
        selectedItem,
        _conditionController.text,
        _quantityController.text,
        _descriptionController.text,
        uid,
        username,
        _file!,
        profImage,
      );
      if (res == 'success') {
        // _showanimation(context, 'assets/done.json');
        Get.snackbar(
          'Success',
          'Product Posted Successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
        );
        setState(() {
          _isLoading = false;
        });
        // showSnackBar('Product Posted', context);
        _titleController.text = '';
        _categoryController.text = '';
        _conditionController.text = '';
        _quantityController.text = '';
        _descriptionController.text = '';
        _file == null;
        Get.off(() => ExplorePage());
      } else {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar(
          'Error',
          res,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Add an image'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.camera,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Choose from gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.gallery,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Cancel'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  _showanimation(BuildContext context, animation) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Lottie.asset(
                animation,
                width: 100,
                height: 100,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Get.back();
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Center(child: Text('Ok')),
              onPressed: () async {
                Navigator.of(context).pop();
                Get.back();
              },
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _categoryController.dispose();
    _conditionController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          "Make a post",
          style: GoogleFonts.workSans(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputWidget(
                        controller: _titleController,
                        label: 'What item are you giving out?',
                        hint: 'Macbook Pro',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _file == null
                          ? Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                              ),
                              child: IconButton(
                                onPressed: () => _selectImage(context),
                                icon: Icon(Icons.image),
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                              ),
                              child: InkWell(
                                onTap: () => _selectImage(context),
                                child: Image(
                                  image: MemoryImage(_file!),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      // InputWidget(
                      //   controller: _categoryController,
                      //   label: 'Select Category',
                      // ),
                      Text(
                        'Select Category',
                        style: GoogleFonts.workSans(fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 15),
                      //   width: MediaQuery.of(context).size.width,
                      //   height: MediaQuery.of(context).size.height * 0.08,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: primaryColor),
                      //     borderRadius: BorderRadius.circular(5),
                      //   ),
                      //   child: DropdownButton(
                      //     isExpanded: true,
                      //     // Initial Value
                      //     value: dropdownvalue,
                      //     underline: SizedBox(),

                      //     // Down Arrow Icon
                      //     icon: const Icon(Icons.keyboard_arrow_down),

                      //     // Array list of items
                      //     items: items.map((String items) {
                      //       return DropdownMenuItem(
                      //         value: items,
                      //         child: Text(items),
                      //       );
                      //     }).toList(),
                      //     // After selecting the desired option,it will
                      //     // change button value to selected value
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         dropdownvalue = newValue!;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("categories")
                            .snapshots(),
                        builder: (context, snapshot) {
                          // if (snapshot.hasData) {
                          //   const Text("Loading.....");
                          // } else {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: LinearProgressIndicator(),
                            );
                          }
                          List<DropdownMenuItem> dropdownItem = [];
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data!.docs[i];
                            dropdownItem.add(
                              DropdownMenuItem(
                                child: Text(
                                  snap['cat_name'],
                                  style: GoogleFonts.workSans(),
                                ),
                                // get cat name as value
                                value: snap['cat_name'],
                              ),
                            );
                          }
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.08,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButton<dynamic>(
                              isExpanded: true,
                              underline: SizedBox(),
                              items: dropdownItem,
                              onChanged: (currencyValue) {
                                setState(() {
                                  selectedItem = currencyValue;
                                });
                              },
                              value: selectedItem,
                              hint: Text(
                                "Choose Category",
                                style: GoogleFonts.workSans(),
                              ),
                            ),
                          );
                          // }
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      InputWidget(
                        controller: _conditionController,
                        label: 'Product Condition',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWidget(
                        controller: _quantityController,
                        label: 'Quantity',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWidget(
                        controller: _descriptionController,
                        label: 'Item Description',
                        height: 150,
                        maxLine: 5,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => postProduct(
                          user.uid,
                          user.username,
                          user.photoUrl,
                        ),
                        child: Button(
                          label: 'Post',
                          height: 60,
                          width: 400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
