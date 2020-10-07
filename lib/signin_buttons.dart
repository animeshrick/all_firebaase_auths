import 'package:all_firebaase_auths/always_main_screen.dart';
import 'package:all_firebaase_auths/gmail.dart';
import 'package:all_firebaase_auths/phone_no_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///email
            SignInButtonBuilder(
              text: 'Continue with Email',
              icon: Icons.email,
              onPressed: () {
                print('Get going with Email');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Gmail()));
                //_showButtonPressDialog(context, 'Email');
              },
              backgroundColor: Colors.blueGrey[700],
              width: 220.0,
            ),
            Divider(),

            ///phone
            SignInButtonBuilder(
              text: 'Verify Phone Number',
              icon: Icons.phone,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhoneNoAuth()));
              },
              backgroundColor: Colors.blueGrey[700],
              width: 220.0,
            ),
            Divider(),

            ///google account
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                await _gSignIn().whenComplete(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AlwaysMainScreen();
                      },
                    ),
                  );
                });
              },
            ),
            Divider(),
            // SignInButton(
            //   Buttons.GoogleDark,
            //   onPressed: () {
            //     print('Google(dark)');
            //     //_showButtonPressDialog(context, 'Google (dark)');
            //   },
            // ),
            // Divider(),

            ///facebook
            SignInButton(
              Buttons.FacebookNew,
              onPressed: () {
                print('Facebook');
                //_showButtonPressDialog(context, 'FacebookNew');
              },
            ),
            // Divider(),
            // SignInButton(
            //   Buttons.Apple,
            //   onPressed: () {
            //     print('Apple');
            //     //_showButtonPressDialog(context, 'Apple');
            //   },
            // ),
            // Divider(),
            // SignInButton(
            //   Buttons.GitHub,
            //   text: "Sign up with GitHub",
            //   onPressed: () {
            //     print('Sign up with GitHub');
            //     //_showButtonPressDialog(context, 'Github');
            //   },
            // ),
            // Divider(),
            // SignInButton(
            //   Buttons.Microsoft,
            //   text: "Sign up with Microsoft ",
            //   onPressed: () {
            //     print("Sign up with Microsoft ");
            //     //_showButtonPressDialog(context, 'Microsoft ');
            //   },
            // ),
            Divider(),
            SignInButton(
              Buttons.Twitter,
              text: "Use Twitter",
              onPressed: () {
                twitterLogin();
                print('Use Twitter');
                //_showButtonPressDialog(context, 'Twitter');
              },
            ),
            // Divider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SignInButton(
            //       Buttons.LinkedIn,
            //       mini: true,
            //       onPressed: () {
            //         print('LinkedIn (mini)');
            //         //_showButtonPressDialog(context, 'LinkedIn (mini)');
            //       },
            //     ),
            //     SignInButton(
            //       Buttons.Tumblr,
            //       mini: true,
            //       onPressed: () {
            //         print('Tumblr (mini)');
            //         //_showButtonPressDialog(context, 'Tumblr (mini)');
            //       },
            //     ),
            //     SignInButton(
            //       Buttons.Facebook,
            //       mini: true,
            //       onPressed: () {
            //         print('Facebook (mini)');
            //         // _showButtonPressDialog(context, 'Facebook (mini)');
            //       },
            //     ),
            //     SignInButtonBuilder(
            //       icon: Icons.email,
            //       text: "Ignored for mini button",
            //       mini: true,
            //       onPressed: () {
            //         movingPage();
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => Gmail()));
            //         print('Email (mini)');
            //         // _showButtonPressDialog(context, 'Email (mini)');
            //       },
            //       backgroundColor: Colors.cyan,
            //     ),
            //   ],
            // ),
          ],
        ),
      ],
      //child:
    );
  }

  Future<User> _gSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return user;
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();

    print("User Signed Out");
  }

  void twitterLogin() async {
    var twitterLogin = new TwitterLogin(
      consumerKey: 'wJGZ2cjHjW8THOd7w3aSFeFIv',
      consumerSecret: 'wjum03ROQcMXiMw3zb0RNUu7xTEFKYVMsWTFTs5Ff6tcr0wm63',
    );

    final TwitterLoginResult result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        var session = result.session;
        //_sendTokenAndSecretToServer(session.token, session.secret);
        print(session.username);
        break;
      case TwitterLoginStatus.cancelledByUser:
        //_showCancelMessage();
        print('cancelled by user');
        break;
      case TwitterLoginStatus.error:
        print(result.errorMessage);
        //_showErrorMessage(result.error);
        break;
    }
  }
}
