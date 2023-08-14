import 'package:flutter/material.dart';
import 'package:flutterotpfield/flutterotpfield.dart';

void main() {
  runApp(const OtpScreen());
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            // with default design
            FlutterOtpField(
              inputFieldLength: 6,
              spaceBetweenFields: 10,
              onValueChange: (String value) {
                print("otp changed $value");
              },
              onCompleted: (String value) {
                print("otp  $value");
              },),
            const SizedBox(height: 50,),
            // with custom input field design
            Center(child: FlutterOtpField(
              inputFieldLength: 6,
              spaceBetweenFields: 10,
              inputDecoration: InputDecoration(
                  constraints: const BoxConstraints(maxHeight: 46),
                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: "0",
                  counterText: "",
                  hintStyle: const TextStyle(
                      color: Color(0xff656565),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xff969696),
                          width: 1.0),
                      borderRadius:
                      BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xff969696),
                          width: 1.0),
                      borderRadius:
                      BorderRadius.circular(8))),
              onValueChange: (String value) {
                print("otp changed $value");
              },
              onCompleted: (String value) {
                print("otp  $value");
              },)),
            const SizedBox(height: 30,),
            Center(child: FlutterOtpField(
              inputFieldLength: 4,
              spaceBetweenFields: 10,
              inputDecoration: InputDecoration(
                  constraints: const BoxConstraints(maxHeight: 46),
                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: "#",
                  counterText: "",
                  hintStyle: const TextStyle(
                      color: Color(0xff656565),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xff969696),
                          width: 1.0),
                      borderRadius:
                      BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xff969696),
                          width: 1.0),
                      borderRadius:
                      BorderRadius.circular(30))),
              onValueChange: (String value) {
                print("otp changed $value");
              },
              onCompleted: (String value) {
                print("otp  $value");
              },)),
          ],
        )
    );
  }
}