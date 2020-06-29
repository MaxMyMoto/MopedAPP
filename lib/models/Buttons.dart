import 'package:MyMoto/iconsss/my_moto_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class MotorradButton extends StatelessWidget {
  MotorradButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context){
    return RawMaterialButton(

      constraints: BoxConstraints.tight(Size( MediaQuery.of(context).size.width / 5,65)),
      padding:const EdgeInsets.only(right: 23.0) ,
      child:
      Icon(MyMotoIcons.meinmotorrad,
        size: 30,color: Colors.white,),
      onPressed: onPressed,
    );
  }
}

class MotorradHelmButton extends StatelessWidget {
  MotorradHelmButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context){
    return RawMaterialButton(
      constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width / 5,65)),
      child: Icon(MyMotoIcons.helmduenn,
        size: 30,color: Colors.white,),
      onPressed: onPressed,
    );
  }
}

class MapsButton extends StatelessWidget {
  MapsButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context){
    return RawMaterialButton(
      constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width / 5,65)),
      child: Icon(MyMotoIcons.locationduenn,
        size: 30,color: Colors.white,),
      onPressed: onPressed,

    );

  }
}

class KostenButton extends StatelessWidget {
  KostenButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context){
    return RawMaterialButton(
      constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width / 5,65)),
      child: Icon(MyMotoIcons.kostenduenn,
        size: 30,color: Colors.white,),
      onPressed: onPressed,
    );
  }
}

class StatsButton extends StatelessWidget {
  StatsButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context){
    return RawMaterialButton(
      constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width / 5,65)),
      child: Icon(MyMotoIcons.statsduenn,
        size: 30,color: Colors.white,),
      onPressed: onPressed,
    );
  }
}