
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class EditProfile extends StatefulWidget {
  final Map<String, dynamic> data;
  const EditProfile({Key? key, required this.data}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String Background='https://images.unsplash.com/photo-1579546929662-711aa81148cf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80';
  String Profile = 'https://www.classifapp.com/wp-content/uploads/2017/09/avatar-placeholder.png';
  late List<bool> isSelected;

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }


  //controllers
  final TextEditingController UsernameControl = TextEditingController();
  final TextEditingController BioControl = TextEditingController();
  final TextEditingController InstagramControl = TextEditingController();
  final TextEditingController FacebookControl = TextEditingController();
  final TextEditingController OtherControl = TextEditingController();



  @override
  Widget build(BuildContext context) {

    UsernameControl.text=widget.data['username'];
    BioControl.text=widget.data['bio'];
    InstagramControl.text=widget.data['socialig'];
    FacebookControl.text=widget.data['socialfb'];
    OtherControl.text=widget.data['socialot'];
    var tog1= toggleget(widget.data['tag']);
    isSelected=tog1;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Edit Profile',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25
            )),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CupertinoButton(
              onPressed: () {
                WriteDetails(UsernameControl,BioControl,InstagramControl,FacebookControl,OtherControl);
              },
              child: Text("Save",
              style: TextStyle(
                fontSize: 18
              ),),
            ),
          ),
        ], //<Widget>[]
        backgroundColor: Colors.black,
        elevation: 50.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        image:DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(Background)
                        )
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0,left: 8),
                        child: CircleAvatar(
                          radius: 45.0,
                          backgroundImage:
                          NetworkImage(Profile),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Username",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16
                            ),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: UsernameControl,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            hintText: "Shown on your profile page",
                            hintStyle: TextStyle(
                                color: Colors.grey[700]
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("About You",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16
                            ),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: BioControl,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: "Tell others a little bit about yourself",
                            hintStyle: TextStyle(
                              color: Colors.grey[700]
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              ToggleButtons(
                borderWidth: 1.5,
                borderRadius: BorderRadius.circular(50),
                selectedBorderColor: Colors.lightBlueAccent,
                borderColor: Colors.grey[500],
                isSelected: isSelected,
                fillColor: Color(0xff5338FF),
                color: Colors.grey[400],
                selectedColor: Colors.white,
                constraints: BoxConstraints(
                  minWidth: 90,
                  minHeight: 40
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text("Singer",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text("Producer",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text("Cover Artist",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                  ),
                ],
                onPressed: (int newIndex){
                  setState(() {
                    for(int index=0;index<isSelected.length;index++){
                      if(index==newIndex){
                        isSelected[index]= !isSelected[index];
                      }
                    }
                  });
                  print(isSelected.toString());
                  // print(togglebuttonstate(isSelected));
                },
              ),
              ListTileTheme(
                contentPadding: EdgeInsets.only(left: 8),
                child: ListTile(leading: Text("Add your interests",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),),
                  dense: true,
                  trailing:Icon(Icons.arrow_forward_ios_rounded,color: Color(0xff5338FF),
                  ),),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text("Social Links",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16
                    ),),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery. of(context). size. width-10,
                          child: TextField(
                            controller: InstagramControl,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              hintText: 'Instagram',
                              hintStyle: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery. of(context). size. width-10,
                          child: TextField(
                            controller: FacebookControl,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              hintText: 'Facebook',
                              hintStyle: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery. of(context). size. width-10,
                          child: TextField(
                            controller: OtherControl,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              hintText: 'Other',
                              hintStyle: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String togglebuttonstate(List<bool> isSelected){
    if (isSelected.toString()=='[false, false, false]'){
      return ("N");
    }else if(isSelected.toString()=='[true, false, false]'){
      return("S");
    }else if(isSelected.toString()=='[false, true, false]'){
      return("P");
    }else if(isSelected.toString()=='[false, false, true]'){
      return("C");
    }else if(isSelected.toString()=='[true, true, false]'){
      return("SP");
    }else if(isSelected.toString()=='[true, false, true]'){
      return("SC");
    }else if(isSelected.toString()=='[false, true, true]'){
      return("PC");
    }else {
      return("ALL");
    }
  }

  Future<void> WriteDetails(TextEditingController usernameControl, TextEditingController bioControl, TextEditingController instagramControl, TextEditingController facebookControl, TextEditingController otherControl) async {

  }


  //retreivers

  Future<void> preusername(String uid1, String username1) async {

  }

  List<bool> toggleget(String artTag){
    List<bool> tog = [false, false, false];
    if(artTag=='S'){
      tog = [true, false, false];
      return tog;
    }else if(artTag=='P'){
      tog = [false, true, false];
      return tog;
    }else if(artTag=='C'){
      tog = [true, false, true];
      return tog;
    }else if(artTag=='SP'){
      tog = [true, true, false];
      return tog;
    }else if(artTag=='SC'){
      tog = [true, false, true];
      return tog;
    }else if(artTag=='PC'){
      tog = [false, true, true];
      return tog;
    }else if(artTag=='ALL'){
      tog = [true, true, true];
      return tog;
    }else{
      tog = [false, false, false];
      return tog;
    }
  }
}
