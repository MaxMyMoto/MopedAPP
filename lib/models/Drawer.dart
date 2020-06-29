import 'package:MyMoto/models/sign_in.dart';
import 'package:MyMoto/screens/MeinKonto.dart';
import 'package:flutter/material.dart';

import 'MenuItem.dart';

class Seitenleiste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Color(0xff1e1e1e),
      child: SafeArea(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[

            SizedBox(
              height: (kToolbarHeight/2),
            ),

            ListTile(
              title: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                email,
                style: TextStyle(
                  color: Color(0xFFe71e2e),
                  fontSize: 15,
                ),
              ),
              leading:

              Container(
                height: 55.0,
                width: 55.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child:

                CircleAvatar(
                  backgroundImage: NetworkImage(
                    imageUrl,
                  ),
                  radius: 40,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),

            SizedBox(
              height: (kToolbarHeight/2),
            ),


            Divider(
              thickness: 0.5,
              color: Colors.white.withOpacity(0.3),
              indent: 32,
              endIndent: 32,
            ),
            MenuItem(
              icon: Icons.home,
              title: "Startseite",
              onTap: () {},
            ),
            MenuItem2(
              icon: Icons.group,
              title: "Community",
              onTap: () {},
            ),
            MenuItem(
              icon: Icons.calendar_today,
              title: "Fälligkeit",
              onTap: () {},
            ),
            MenuItem(
              icon: Icons.person,
              title: "Mein Konto",
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MeinKonto()),);},
            ),
            Divider(
              thickness: 0.5,
              color: Colors.white.withOpacity(0.3),
              indent: 32,
              endIndent: 32,
            ),
            MenuItem(
              icon: Icons.settings,
              title: "Einstellungen",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
