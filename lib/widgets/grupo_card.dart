// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:exotica_app/models/grupo_model.dart';
import 'package:exotica_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class GruposCardView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  final GrupoModel grupo;

  GruposCardView({
    Key? key, 
    required this.animation,
    required this.animationController,
    required this.grupo
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {    
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues( 0.0, 30 * (1.0 - animation!.value), 0.0),
              child: Padding(
                padding: EdgeInsets.only(left: 24, right: 24, top: 5, bottom: 5),
                child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.4),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: Image.asset(grupo.icon.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }  

}
