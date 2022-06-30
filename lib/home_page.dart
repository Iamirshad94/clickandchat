import 'package:call_log/call_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String? validatorText;
  var phone='';
  var message='';
  TextEditingController userInput = TextEditingController();
  TextEditingController userMsg = TextEditingController();


  AppLifecycleState? _notification;
  Future<Iterable<CallLogEntry>>? logs;

  _launchUrl(String number, String? msg) async {
    var url = 'https://wa.me/91$number?text=$msg';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }




  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF075E54),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,right: 4.0,top: 4.0,),
                  child: SizedBox(
                    height: screenSize.height / 2.5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Keep\nYour\nPhonebook\nClean",
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,right: 4.0,top: 0.0,bottom: 4.0),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            'Send media & chat with anyone without worrying about saving phone number, Just enter number & message and send',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 18,
                              // fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenSize.width,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                          child: Divider(
                            thickness: 3.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: screenSize.height / 2.2,
                  width: screenSize.width,
                  decoration: const BoxDecoration(
                      color: Color(0xFF17212d),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: userInput,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter phone number',
                              hintStyle: TextStyle(color: Colors.white70),
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: Colors.white70,
                              ),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              setState(() {
                                phone=value;
                                userInput.text = value.toString();
                                final val = TextSelection.collapsed(
                                    offset: userInput.text.length);
                                userInput.selection = val;
                                print('phone ${phone}');

                              });
                            },
                            validator: (value) {

                              if (value == null || value.isEmpty) {
                                return 'Please enter Mobile Number';
                              }
                              if (value.length != 10) {
                                return 'Please Enter Valid Mobile Number';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines:
                            1, //Normal textInputField will be displayed
                            maxLines: 5,
                            controller: userMsg,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.message,
                                color: Colors.white70,
                              ),
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.white70),
                              hintText: 'type message (optional)',
                            ),
                            onChanged: (value) {
                              setState(() {
                                message=value;
                                userMsg.text = value.toString();
                                final val = TextSelection.collapsed(
                                    offset: userMsg.text.length);
                                userMsg.selection = val;
                                 print('Message ${message}');
                              });
                            },
                          ),
                          InkWell(
                              onTap: () async {
                                _launchUrl(phone, message);
                              },
                            child: SizedBox(
                              width: screenSize.width/2.5,
                              child: Image.asset('assets/images/w_btn.png'),
                            ),
                          ),
                          
                          InkWell(
                              onTap: (){
                              },
                              child: const Text("Privacy Policy",style: TextStyle(color: Colors.white70),))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // / This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
