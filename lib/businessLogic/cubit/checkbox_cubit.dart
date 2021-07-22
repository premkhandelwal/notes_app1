import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'checkbox_state.dart';

class CheckboxCubit extends Cubit<CheckBoxState> {
  CheckboxCubit() : super(CheckBoxState(checkBoxVal: false));
  void changeCheckBoxVal(bool newValue) {

      if (newValue) {
        emit(CheckboxValTrue());
      } else {
        emit(CheckboxValFalse());
      }
  }
}
