import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobileshop/viewModel/cartDetails/states.dart';

class DetailsCubit extends Cubit<ItemDetails> {
  DetailsCubit() : super(DetailsInitState());

  void getItemsDetails() {
    // FirebaseFirestore.instance.collection()
  }
}
