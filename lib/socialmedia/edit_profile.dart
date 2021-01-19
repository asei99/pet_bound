import 'dart:io';
import 'package:image/image.dart' as ImD;
import 'package:Pet_Bound/Model/m_user.dart';
import 'package:Pet_Bound/socialmedia/home_page.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Editprofile extends StatefulWidget {
  final String currentOnlineUserId;

  Editprofile({this.currentOnlineUserId});
  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  TextEditingController profileNameTextEditingController =
      TextEditingController();
  TextEditingController bioTextEditingController = TextEditingController();
  firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child('Users Picture');

  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  String profileId = Uuid().v4();

  bool loading = false;
  Users user;
  bool _bioValid = true;
  bool _profileNameValid = true;
  File file;
  void initState() {
    getAndDisplayUserInformation();
    super.initState();
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
    });
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    final imageFile = File(await ImagePicker()
        .getImage(source: ImageSource.gallery)
        .then((pickedFile) => pickedFile.path));
    setState(() {
      this.file = imageFile;
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

  getAndDisplayUserInformation() async {
    setState(() {
      loading = true;
    });

    DocumentSnapshot documentSnapshot =
        await usersReference.doc(currentUser.id).get();
    user = Users.fromDocument(documentSnapshot);

    profileNameTextEditingController.text = user.userName;
    bioTextEditingController.text = user.bio;

    setState(() {
      loading = false;
    });
  }

  compressingPhoto() async {
    final tDirectory = await getTemporaryDirectory();
    final path = tDirectory.path;
    ImD.Image mImageFile = ImD.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$profileId.jpg')
      ..writeAsBytesSync(ImD.encodeJpg(mImageFile, quality: 60));
    setState(() {
      file = compressedImageFile;
    });
  }

  Future<String> uploadPhoto(mImageFile) async {
    firebase_storage.UploadTask mStorageUploadTask =
        storageReference.child('post_$profileId.jpg').putFile(mImageFile);
    firebase_storage.TaskSnapshot storageTaskSnapshot =
        await mStorageUploadTask;
    if (storageTaskSnapshot.state == firebase_storage.TaskState.success) {
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    return 'eror bro';
  }

  updateUserData() async {
    String deleteId = user.profileurl;

    FocusScope.of(context).unfocus();
    setState(() {
      profileNameTextEditingController.text.trim().length < 3 ||
              profileNameTextEditingController.text.isEmpty
          ? _profileNameValid = false
          : _profileNameValid = true;

      bioTextEditingController.text.trim().length > 110
          ? _bioValid = false
          : _bioValid = true;
    });

    if (file != null && _bioValid && _profileNameValid) {
      storageReference.child("post_$deleteId.jpg").delete();
      await compressingPhoto();
      String downloadUrl = await uploadPhoto(file);
      usersReference.doc(currentUser.id).update({
        "username": profileNameTextEditingController.text,
        "bio": bioTextEditingController.text,
        "image": downloadUrl,
        "profileurl": profileId,
      });
      SnackBar successSnackBar =
          SnackBar(content: Text("Profile has been updated successfully."));
      _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);

      // clearPostInfo();
      // Navigator.of(context).pop();
    }

    if (_bioValid && _profileNameValid) {
      usersReference.doc(currentUser.id).update({
        "username": profileNameTextEditingController.text,
        "bio": bioTextEditingController.text,
        "profileurl": profileId,
      });
      SnackBar successSnackBar =
          SnackBar(content: Text("Profile has been updated successfully."));
      _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);

      // clearPostInfo();
      // Navigator.of(context).pop();
    }
  }

  clearPostInfo() {
    setState(() {
      file = null;

      profileId = Uuid().v4();
    });
  }

  void back(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (loading == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: CircularProgressIndicator()),
        ],
      );
    }
    return Scaffold(
      key: _scaffoldGlobalKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            MaterialIcons.arrow_back,
            color: Color.fromRGBO(237, 171, 172, 5),
          ),
          onPressed: () => back(context),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(237, 171, 172, 5),
        ),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
        title: Text(
          "Edit Profile",
          style:
              TextStyle(fontFamily: 'acme', fontSize: 25, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              MaterialCommunityIcons.floppy,
              color: Color.fromRGBO(237, 171, 172, 5),
              size: 30.0,
            ),
            onPressed: () => updateUserData(),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                // currentUser.image == null
                //     ?

                file == null
                    ? Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 7),
                        child: GestureDetector(
                          onTap: () => takeImage(context),
                          child: Container(
                            height: size.height * 1 / 6,
                            width: size.height * 1 / 6,
                            child: user.image != null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(user.image),
                                    backgroundColor: Colors.grey[300],
                                  )
                                : Center(
                                    child: Icon(
                                      Entypo.camera,
                                      size: 35,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 7.0),
                        child:
                            //  user.image==null?
                            GestureDetector(
                          onTap: () => takeImage(context),
                          child: Container(
                              height: size.height * 1 / 6,
                              width: size.height * 1 / 6,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(100)),
                              child: CircleAvatar(
                                backgroundImage: FileImage(file),
                                backgroundColor: Colors.grey[300],
                              )),
                        ),
                      ),
                // : Padding(
                //     padding: EdgeInsets.only(top: 15.0, bottom: 7.0),
                //     child: CircleAvatar(
                //       radius: 52.0,
                //       backgroundImage:
                //           CachedNetworkImageProvider(user.image),
                //     ),
                //   ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      createProfileNameTextFormField(),
                      createBioTextFormField()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column createProfileNameTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Profile Name",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.black),
          controller: profileNameTextEditingController,
          decoration: InputDecoration(
            hintText: "Write profile name here...",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintStyle: TextStyle(color: Colors.grey),
            errorText: _profileNameValid ? null : "Profile name is very short",
          ),
        ),
      ],
    );
  }

  Column createBioTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Bio",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.black),
          controller: bioTextEditingController,
          decoration: InputDecoration(
            hintText: "Write Bio here...",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintStyle: TextStyle(color: Colors.grey),
            errorText: _bioValid ? null : "Bio is very Long.",
          ),
        ),
      ],
    );
  }
}
