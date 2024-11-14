import 'package:flutter_bloc/flutter_bloc.dart';

class AddCubit extends Cubit<bool> {
  AddCubit() : super(false);

  void showAddInput() {
    emit(!state);
  }
}
