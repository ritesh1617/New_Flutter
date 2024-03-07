import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/color.dart';


class CButton extends StatelessWidget {
  final String? title;
  final AnimationController? btnCntrl;
  final Animation? btnAnim;
  final VoidCallback? onBtnSelected;
  Color? color=null;
  Color? textColor=null;
  double radius=20.0;
  LinearGradient gradient;

  CButton(
      {Key? key,this.color,this.textColor, this.title, this.btnCntrl, this.btnAnim, this.onBtnSelected,this.radius=25.0,this.gradient=const LinearGradient(colors: [colors.firstColor,colors.secondColor])})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildBtnAnimation,
      animation: btnCntrl!,
    );
  }

  Widget _buildBtnAnimation(BuildContext context, Widget? child) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
      child: GestureDetector(
        child: Container(
          width: btnAnim!.value,
          height: 45,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
          //  color: (color==null)?colors.primary:color,
           gradient:  gradient,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          child: btnAnim!.value > 75.0
              ? Text(title!,
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: (textColor==null)?colors.whiteTemp:textColor, fontWeight: FontWeight.normal))
              : const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(colors.whiteTemp),
          ),
        ),
        onTap : () {
          onBtnSelected!();
        },
      ),
    );
  }
}
