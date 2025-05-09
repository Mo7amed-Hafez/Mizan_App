  import 'package:flutter/material.dart';
import 'package:mizan/database/constant.dart';

Widget buildTextFormField(
    String hint, {
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? toggleVisibility,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: isPassword ? !isVisible : false,
        obscuringCharacter: "\$",
        validator: (value) =>
            value == null || value.isEmpty ? "من فضلك أدخل $hint" : null,
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.black,fontFamily: kfontStyle4),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
        ),
      ),
    );
  }

  Widget buildContainer(
  String textContainer,
  String imageContainer,
  BuildContext context, 
) {
  return Container(
    padding: const EdgeInsets.all(5),
    width:
        MediaQuery.of(context).size.width * 0.98, 
    height: MediaQuery.of(context).size.height * 0.15,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: kPrimaryColor3,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(radius: 35, backgroundImage: AssetImage(imageContainer)),
        const SizedBox(width: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            textContainer,
            textAlign: TextAlign.right,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: kfontStyle1,
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget buildImage(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "ليس لديك أي أقساط بعد.",
            style: TextStyle(
              color: kPrimaryColor3,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: kfontStyle3,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            width: MediaQuery.of(context).size.width * 0.98,
            height: MediaQuery.of(context).size.height * 0.47,
            decoration: BoxDecoration(
              color: kPrimaryColor2,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset("assets/images/no quest.gif", fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
  

  
  Widget buildTextField(
    String hint,
    String label, {
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onEyePressed,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !isVisible : false,
        decoration: InputDecoration(
          filled: true,
          hintText: hint,
          labelText: label,
          fillColor: const Color.fromARGB(135, 158, 158, 158),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: onEyePressed,
                )
              : null,
        ),
      ),
    );
  }
