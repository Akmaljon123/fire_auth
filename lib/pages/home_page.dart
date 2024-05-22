import 'package:fire_auth/pages/login_page.dart';
import 'package:fire_auth/services/authentication_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w400
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),

              Text(AuthenticationService.auth.currentUser!.displayName ?? ""),

              const SizedBox(height: 20),

              MaterialButton(
                onPressed: ()async{

                  showDialog(
                      context: context,
                      builder: (context){
                        return Column(
                          children: [
                            TextField(
                              controller: controller,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                hintText: "New password"
                              ),
                            )
                          ],
                        );
                      }
                  );


                  await AuthenticationService.editPassword(controller.text);

                  Navigator.pop(context);
                },
                padding: const EdgeInsets.symmetric(horizontal: 30),
                minWidth: 340,
                height: 50,
                shape: const StadiumBorder(),
                color: Colors.blue,
                child: const Text("Change password",style: TextStyle(color: Colors.white, fontSize: 18)),
              ),

              const SizedBox(height: 10),

              MaterialButton(
                onPressed: ()async{
                  await AuthenticationService.logout();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context)=>const LoginPage())
                  );
                },
                padding: const EdgeInsets.symmetric(horizontal: 30),
                minWidth: 340,
                height: 50,
                shape: const StadiumBorder(),
                color: Colors.blue,
                child: const Text("Log out",style: TextStyle(color: Colors.white, fontSize: 18)),
              ),

              const SizedBox(height: 10),

              MaterialButton(
                onPressed: ()async{
                  await AuthenticationService.delete();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context)=>const LoginPage())
                  );
                },
                padding: const EdgeInsets.symmetric(horizontal: 30),
                minWidth: 340,
                height: 50,
                shape: const StadiumBorder(),
                color: Colors.blue,
                child: const Text("Delete",style: TextStyle(color: Colors.white, fontSize: 18)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
