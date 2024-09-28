import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/ui/airquality.dart';
import 'package:weather_app/ui/mainapp.dart';

class firstscreen extends StatelessWidget {
  const firstscreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    Constants myConstants = Constants();
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          color:  myConstants.primaryColor.withOpacity(0.4),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.asset('assets/clear.png'),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> mainApp()));
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Airquality()));
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: myConstants.secondColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),

                    child: Center(
                      child: Text("Start", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ),
                )
              ],
            ),
          )
      ),

    );
  }
}


