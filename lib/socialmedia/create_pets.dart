import 'dart:io';
import 'package:Pet_Bound/Model/m_category.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as ImD;
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Createpets extends StatefulWidget {
  final String currentUser;

  Createpets({this.currentUser});
  static const lst = ['Male', 'Female'];

  static List dropdownlist = ['Cat', 'Dog'];
  @override
  _CreatepetsState createState() => _CreatepetsState();
}

class _CreatepetsState extends State<Createpets> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child('Pets Picture');
  String petId = Uuid().v4();
  bool uploading = false;
  File file;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController borndateTextEditingController = TextEditingController();
  TextEditingController weigthTextEditingController = TextEditingController();
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController categoryTextEditingController = TextEditingController();
  TextEditingController breedTextEditingController = TextEditingController();
  TextEditingController aboutTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  TextEditingController formatedDateTextEditingController =
      TextEditingController();

  final petRefrence = FirebaseFirestore.instance.collection("pets");
  String categoryname;
  String categoryurl;
  List<Categories> categoryItem = [];
  String category = "6rIL4tfjhh9AdJIumv0C";
  Categories categories;

  void initState() {
    super.initState();

    getAllCategory();
  }

  getAllCategory() async {
    // setState(() {
    //   // loading = true;
    // });
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("petcategories").get();
    if (mounted) {
      setState(() {
        // loading = false;
        categoryItem = querySnapshot.docs
            .map((eachPost) => Categories.fromDocument(eachPost))
            .toList();
        // querySnapshot.docs.map(doc) => Petwidget.fromDocument(doc)).toList();
      });
    }
  }

  displayDropDown() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('petcategories').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(
            child: CircularProgressIndicator(),
          );
        // var length = snapshot.data.docs.length;
        // DocumentSnapshot ds = snapshot.data.docs[length - 1];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Category'),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              // color: Colors.grey,
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              child: new DropdownButton(
                value: category,
                // isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                    category = newValue;

                    print(category);
                  });
                },
                items: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new DropdownMenuItem<String>(
                      value: document.data()['id'],
                      child: new Container(
                        decoration: new BoxDecoration(
                            // color: primaryColor,
                            borderRadius: new BorderRadius.circular(30.0)),
                        // height: 100.0,
                        // padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                        //color: primaryColor,
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.all(
                                  new Radius.circular(60.0),
                                ),
                                border: new Border.all(color: Colors.transparent
                                    // color: Colors.black,
                                    // width: 3.0,
                                    ),
                              ),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    NetworkImage(document.data()["url"]),
                                backgroundColor: Colors.grey[300],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(document.data()['categorie'])
                          ],
                        ),
                      ));
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  void back(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  int selectedIndex = 0;
  String genderValue;
  bool imagePicked = false;

  Widget genderRadio(String txt, int index) {
    return InkWell(
      onTap: () => changeIndex(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectedIndex == index
              ? Color.fromRGBO(237, 171, 172, 5)
              : Colors.grey,
        ),
        width: 150,
        height: 40,
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
              fontFamily: 'acme',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: selectedIndex == index ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    final imageFile = File(await ImagePicker()
        .getImage(
          source: ImageSource.camera,
          maxHeight: 680,
          maxWidth: 970,
        )
        .then((pickedFile) => pickedFile.path));
    setState(() {
      this.file = imageFile;
      imagePicked = true;
    });
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    final imageFile = File(await ImagePicker()
        .getImage(source: ImageSource.gallery)
        .then((pickedFile) => pickedFile.path));
    setState(() {
      this.file = imageFile;
      imagePicked = true;
    });
  }

  compressingPhoto() async {
    final tDirectory = await getTemporaryDirectory();
    final path = tDirectory.path;
    ImD.Image mImageFile = ImD.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$petId.jpg')
      ..writeAsBytesSync(ImD.encodeJpg(mImageFile, quality: 60));
    setState(() {
      file = compressedImageFile;
    });
  }

  Future<String> uploadPhoto(mImageFile) async {
    firebase_storage.UploadTask mStorageUploadTask =
        storageReference.child('post_$petId.jpg').putFile(mImageFile);
    firebase_storage.TaskSnapshot storageTaskSnapshot =
        await mStorageUploadTask;
    if (storageTaskSnapshot.state == firebase_storage.TaskState.success) {
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    return 'eror bro';
  }

  clearPostInfo() {
    nameTextEditingController.clear();
    heightTextEditingController.clear();
    breedTextEditingController.clear();
    aboutTextEditingController.clear();
    weigthTextEditingController.clear();

    setState(() {
      imagePicked = false;
      file = null;
      uploading = false;
      petId = Uuid().v4();
    });
  }

  controlUploadAndSave() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (file == null) {
      var snackbar = SnackBar(
        content: Text("Please select an image"),
        backgroundColor: Theme.of(context).errorColor,
      );
      return _scaffoldKey.currentState.showSnackBar(snackbar);
    }
    // setState(() {
    //   uploading = true;
    // });

    if (isValid) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("petcategories")
          .doc(category)
          .get();
      categories = Categories.fromDocument(documentSnapshot);

      setState(() {
        uploading = true;
        categoryname = categories.category;
        categoryurl = categories.categoryurl;
      });
      await compressingPhoto();
      String downloadUrl = await uploadPhoto(file);
      String genderValue;
      if (selectedIndex == 1) {
        genderValue = "Female";
      } else if (selectedIndex == 0) {
        genderValue = "Male";
      }

      savePostInfoToFireStore(
          url: downloadUrl,
          name: nameTextEditingController.text,
          gender: genderValue,
          weight: weigthTextEditingController.text,
          height: heightTextEditingController.text,
          breed: breedTextEditingController.text,
          borndate: formatedDateTextEditingController.text,
          about: aboutTextEditingController.text,
          category: categoryname,
          categoryurl: categoryurl,
          categoryid: category);

      clearPostInfo();
      Navigator.pop(context);
    }
  }

//BELUM NGEPASSSING BORN DATE dan kategori
  savePostInfoToFireStore(
      {String url,
      String name,
      String gender,
      String weight,
      String height,
      String breed,
      String borndate,
      String about,
      String category,
      String categoryurl,
      String categoryid}) {
    petRefrence.doc(widget.currentUser).collection("usersPets").doc(petId).set({
      "petId": petId,
      "ownerId": widget.currentUser,
      "petname": name,
      "petgender": gender,
      "borndate": borndate,
      "weight": weight,
      "height": height,
      "category": category,
      "categoryurl": categoryurl,
      "breed": breed,
      "about": about,
      "url": url,
      "categoryid": categoryid,
    });
  }

  takeImage(mContext) {
    return showDialog(
      context: mContext,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Color.fromRGBO(237, 171, 172, 5),
          title: Text(
            "New Post",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(
                "Capture Image with Camera",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: captureImageWithCamera,
            ),
            SimpleDialogOption(
              child: Text(
                "Select Image from Gallery",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: pickImageFromGallery,
            ),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  int value = 1;
  String valcategory;
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    final DateFormat formatter = DateFormat('d MMM y');

    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2019, 8),
          lastDate: DateTime(2100));
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          var date =
              "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
          dateTextEditingController.text = date;
          formatedDateTextEditingController.text = date;

          formatedDateTextEditingController.value =
              TextEditingValue(text: formatter.format(picked));
        });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
        title: Text(
          'Create Pets',
          style:
              TextStyle(fontFamily: 'acme', fontSize: 25, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            constraints: BoxConstraints(),
            icon: Icon(
              AntDesign.pluscircleo,
              color: Color.fromRGBO(237, 171, 172, 5),
            ),
            onPressed: () => controlUploadAndSave(),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            MaterialIcons.arrow_back,
            color: Color.fromRGBO(237, 171, 172, 5),
          ),
          onPressed: () => back(context),
        ),
      ),
      body: uploading
          ? LinearProgressIndicator()
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'tell us about',
                      style: TextStyle(
                          fontFamily: 'lato',
                          fontSize: 30,
                          color: Color.fromRGBO(237, 171, 172, 5),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'your pet',
                      style: TextStyle(
                          fontFamily: 'lato',
                          fontSize: 30,
                          color: Color.fromRGBO(237, 171, 172, 5),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    imagePicked == false
                        ? GestureDetector(
                            onTap: () => takeImage(
                                context), //BELUM COMPRESS DAN SAVE KE STORAGE
                            child: Container(
                              width: double.infinity,
                              color: Colors.grey,
                              height:
                                  MediaQuery.of(context).size.height * 1 / 6,
                              child: Center(
                                child: Text('input images'),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => takeImage(
                                context), //BELUM COMPRESS DAN SAVE KE STORAGE
                            child: Container(
                              width: double.infinity,
                              height:
                                  MediaQuery.of(context).size.height * 1 / 6,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: FileImage(file),
                                fit: BoxFit.cover,
                              )),
                            ),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Name'),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'pet name is empty';
                                  }
                                  return null;
                                },
                                controller: nameTextEditingController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  fillColor: Colors.grey,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(237, 171, 172, 5),
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Gender'),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    genderRadio(Createpets.lst[0], 0),
                                    Spacer(),
                                    genderRadio(Createpets.lst[1], 1),
                                  ],
                                ),
                              ]),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Born Date'),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  // color: Colors.grey,
                                  // height: 45,
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'born date is empty';
                                        }
                                        return null;
                                      },
                                      controller:
                                          formatedDateTextEditingController,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                              MaterialCommunityIcons.calendar),
                                          onPressed: () => _selectDate(context),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        fillColor: Colors.grey,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                237, 171, 172, 5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Weight'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      // color: Colors.grey,

                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Weight is empty';
                                          }
                                          return null;
                                        },
                                        controller: weigthTextEditingController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  237, 171, 172, 5),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      child: Center(
                                        child: Text('KG'),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Height'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      // color: Colors.grey,
                                      // height: 45,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Height is empty';
                                          }
                                          return null;
                                        },
                                        controller: heightTextEditingController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  237, 171, 172, 5),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      child: Center(
                                        child: Text('CM'),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          displayDropDown(),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Breed'),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                // color: Colors.grey,
                                // height: 45,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Breed is empty';
                                    }
                                    return null;
                                  },
                                  controller: breedTextEditingController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(237, 171, 172, 5),
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('About'),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                // color: Colors.grey,
                                // height: 45,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'about is empty';
                                    }
                                    return null;
                                  },
                                  controller: aboutTextEditingController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(237, 171, 172, 5),
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
