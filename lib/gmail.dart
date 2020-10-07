import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';

//final GoogleSignIn _googleSignIn = GoogleSignIn();

class Gmail extends StatefulWidget {
  @override
  _GmailState createState() => _GmailState();
}

class _GmailState extends State<Gmail> {
  TextEditingController _controller;
  String email, password;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller,
            textAlign: TextAlign.center,
            enableSuggestions: true,
            maxLines: 2,
            minLines: 1,
            validator: (_val) {
              if (_val.isEmpty) {
                return "Can't be empty";
              } else {
                return null;
              }
            },
            // onChanged: (val) {
            //   email = val;
            // },
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter Email'),
          ),
          Divider(),
          TextFormField(
            controller: _controller,
            obscureText: true,
            textAlign: TextAlign.center,
            enableSuggestions: true,
            validator: MultiValidator([
              RequiredValidator(errorText: "This Field Is Required."),
              MinLengthValidator(6, errorText: "Minimum 6 Characters Required.")
            ]),
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter a Password'),
          ),
          Divider(),
          FlatButton(
            textColor: Colors.white,
            color: Colors.blueGrey,
            padding: EdgeInsets.symmetric(horizontal: 150),
            child: Text('Continue'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            textColor: Colors.white,
            color: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: 150),
            child: Text('Sign Out'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
