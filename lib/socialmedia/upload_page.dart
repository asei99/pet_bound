import 'dart:io';
import 'package:Pet_Bound/Model/m_user.dart';
import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;
import 'package:uuid/uuid.dart';

class UploadPage extends StatefulWidget {
  final Users currentUser;
  UploadPage({this.currentUser});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  final postsReference = FirebaseFirestore.instance.collection("posts");

  firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child('Posts Picture');
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String postId = Uuid().v4();
  bool uploading = false;
  File file;
  TextEditingController descriptionTextEditingController =
      TextEditingController();

  compressingPhoto() async {
    final tDirectory = await getTemporaryDirectory();
    final path = tDirectory.path;
    ImD.Image mImageFile = ImD.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(ImD.encodeJpg(mImageFile, quality: 60));
    setState(() {
      file = compressedImageFile;
    });
  }

  controlUploadAndSave() async {
    FocusScope.of(context).unfocus();

    if (file == null) {
      var snackbar = SnackBar(
        content: Text("Please select an image"),
        backgroundColor: Theme.of(context).errorColor,
      );
      return _scaffoldKey.currentState.showSnackBar(snackbar);
    }
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      setState(() {
        uploading = true;
      });
      await compressingPhoto();
      String downloadUrl = await uploadPhoto(file);

      savePostInfoToFireStore(
          url: downloadUrl, description: descriptionTextEditingController.text);
      savePostInfoToTimelineFireStore(
          url: downloadUrl, description: descriptionTextEditingController.text);

      clearPostInfo();

      var snackbar = SnackBar(
        content: Text(
          "Success Upload Post",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.green,
      );
      return _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  savePostInfoToTimelineFireStore({String url, String description}) {
    timelineRefrence
        .doc(currentUser.id)
        .collection("timelinePosts")
        .doc(postId)
        .set({
      "postId": postId,
      "ownerId": currentUser.id,
      "timestamp": DateTime.now(),
      "likes": {},
      "username": currentUser.userName,
      "description": description,
      "url": url,
    });
  }

  savePostInfoToFireStore({String url, String description}) {
    postsReference
        .doc(currentUser.id)
        .collection("usersPosts")
        .doc(postId)
        .set({
      "postId": postId,
      "ownerId": currentUser.id,
      "timestamp": DateTime.now(),
      "likes": {},
      "username": currentUser.userName,
      "description": description,
      "url": url,
    });
  }

  Future<String> uploadPhoto(mImageFile) async {
    firebase_storage.UploadTask mStorageUploadTask =
        storageReference.child('post_$postId.jpg').putFile(mImageFile);
    firebase_storage.TaskSnapshot storageTaskSnapshot =
        await mStorageUploadTask;
    if (storageTaskSnapshot.state == firebase_storage.TaskState.success) {
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    return 'eror bro';
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

  clearPostInfo() {
    descriptionTextEditingController.clear();

    setState(() {
      file = null;
      uploading = false;
      postId = Uuid().v4();
    });
  }

  displayUploadPost() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          uploading ? LinearProgressIndicator() : Text(""),
          Container(
            width: double.infinity,
            height: 270,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: FileImage(file),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Write Caption',
            style: TextStyle(
                fontFamily: 'lato', fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.length > 25) {
                      return 'maximal characters is 25';
                    }
                    return null;
                  },
                  controller: descriptionTextEditingController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    fillColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  displayUploadImage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          uploading ? LinearProgressIndicator() : Text(""),
          GestureDetector(
            onTap: () => takeImage(context),
            child: Card(
              elevation: 6,
              child: Container(
                width: double.infinity,
                height: 270,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text('Choose Image'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
        title: GestureDetector(
          onDoubleTap: () => clearPostInfo(),
          child: Container(
            child: Text(
              'New Post',
              style: TextStyle(
                  fontFamily: 'acme', fontSize: 25, color: Colors.black),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            constraints: BoxConstraints(),
            icon: Icon(
              MaterialCommunityIcons.floppy,
              color: Color.fromRGBO(237, 171, 172, 5),
              size: 30,
            ),
            onPressed: () => controlUploadAndSave(),
          ),
        ],
      ),
      body: uploading
          ? LinearProgressIndicator()
          : SingleChildScrollView(
              child: file == null ? displayUploadImage() : displayUploadPost(),
            ),
    );
  }
}
