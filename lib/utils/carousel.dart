import 'package:fluttertoast/fluttertoast.dart';

class CarouselItems {
  String images;
  String text;

  CarouselItems({required this.images, required this.text});
}

List caoursel = [
  CarouselItems(
    images:
        'https://st.depositphotos.com/1026550/4380/i/600/depositphotos_43807431-stock-photo-halloween.jpg',
    text: 'Horror',
  ),
  CarouselItems(
    images:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcjojfQjtmSXRNgZlFxFIzR4_OfXCxpbsaaw&usqp=CAU',
    text: 'Comedy',
  ),
  CarouselItems(
    images:
        'https://cdn.pixabay.com/photo/2015/12/06/18/28/capsules-1079838_960_720.jpg',
    text: 'Thriller',
  ),
  CarouselItems(
    images:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlHAf9AAzUT2DBdGqDCazt6Wqha7RXFnYHMw&usqp=CAU',
    text: 'Kids',
  ),
  CarouselItems(
    images:
        'https://upload.wikimedia.org/wikipedia/en/1/1d/Muna_Madan_-_book_cover.jpg',
    text: 'Nepali',
  ),
];


dislpayMessage(String msg) {
  Fluttertoast.showToast(msg: msg);
}