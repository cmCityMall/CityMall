import 'package:uuid/uuid.dart';

import '../model/week_promotion.dart';

const mockSubImage =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7CksVEvsuSeI7PJ-wem1rWjDeDSMmhC2bgMRQhAG&s";
const mockProfile =
    "https://png.pngtree.com/png-vector/20191103/ourmid/pngtree-handsome-young-guy-avatar-cartoon-style-png-image_1947775.jpg";
const mockMainCategory =
    "https://cdn.searchenginejournal.com/wp-content/uploads/2021/01/category-pages-featured-image-5ffbf8cca689f.png";
const mockBrandImage =
    "https://www.marketingdonut.co.uk/sites/default/files/branding_overview_371705137.jpg";
const normalProductImage =
    "https://img.freepik.com/premium-vector/shampoo-bottle-hair-cosmetics-self-care-beauty-fashion-health-skincare-routine-cosmetic-products-hand-draw-vector-cartoon-illustration_501069-1459.jpg";
const sizeAndColorProduct = {
  "1": {
    "image":
        "https://underarmour.scene7.com/is/image/Underarmour/PS1329590-001_HF?rp=standard-0pad|pdpMainDesktop&scl=1&fmt=jpg&qlt=85&resMode=sharp2&cache=on,on&bgc=F0F0F0&wid=566&hei=708&size=566,708",
    "size": "S",
    "color": "#080707",
    "price": 25000,
  },
  "2": {
    "image":
        "https://underarmour.scene7.com/is/image/Underarmour/PS1329590-100_HF?rp=standard-0pad|pdpMainDesktop&scl=1&fmt=jpg&qlt=85&resMode=sharp2&cache=on,on&bgc=F0F0F0&wid=566&hei=708&size=566,708",
    "size": "M",
    "color": "#f2f7f4",
    "price": 27000,
  },
  "3": {
    "image":
        "https://underarmour.scene7.com/is/image/Underarmour/PS1329590-601_HF?rp=standard-0pad|pdpMainDesktop&scl=1&fmt=jpg&qlt=85&resMode=sharp2&cache=on,on&bgc=F0F0F0&wid=566&hei=708&size=566,708",
    "size": "L",
    "color": "#eb4034",
    "price": 28000,
  }
};
const productDesc =
    "Mp3 Juice was an amazing application for downloading MP3s however, there are a lot of pop-ups which force you to hit back the button making it nearly impossible to download songs."
    "The first step in downloading your most loved mp3 tune on Mp3 Juice is to go to the site. Since it's an online platform, users don't require downloading or installing any application on your computer. Simply visit Mp3 Juice's website Mp3 Juice website and download the track on the internet."
    "Mp3juices is a breeze to use, there is no need to sign up to download music mp3 using Mp3juice, a music downloader that works with Mp3Ju. With Mp3 Juice, you are able to easily download your favourite songs at any moment. Mp3juice is a free music download program specifically designed for those who love music and want to listen to music in a new method and download music absolutely free."
    "MP3Juice Downloader is one the most popular MP3 download websites for no cost downloads of MP3 songs without the need for software. There is no registration or registration needed to begin the no-cost download of MP3 music. The online music downloader is compatible with the most popular browsers on the internet including Chrome, Firefox, Safari, Opera and Microsoft Edge."
    "Mp3juices - The top music downloads. Many music download services are paid for by ads or can only be downloaded with a premium option. Mp3juice is a no-cost music downloader with no advertisements, viruses and 100% free music downloads. It is not only an internet-based music downloader it's also the most reliable free music downloader application available that works on all platforms and allows for keywords and URLs for music downloads."
    "Music search for free with MP3 download. Mp3 Juice is an app for downloading music that allows users to locate music, play it through the app and download music for free to listen offline to music. You can listen to millions of your most loved songs by searching for them by title or by artist and albums.";
const advertisementImages = [
  "https://www.elmens.com/wp-content/uploads/2019/08/How-You-Can-Use-Shopping-Bags-to-Advertise-Your-Business.jpg",
  "https://www.pinclipart.com/picdir/big/574-5746892_shopping-bags-clip-art.png",
  "https://cdn.dribbble.com/users/2155131/screenshots/15595238/media/f44d40787bf70481f5688055e1172d8a.jpg?compress=1&resize=400x300&vertical=top",
  "https://cdn.dribbble.com/users/2155131/screenshots/15547059/media/e5ba48ae203e996ef243e9b85f03eb0d.jpg?compress=1&resize=400x300&vertical=top",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFdEW9PeP8d-EMkBB4raQNP3FttEYayK23hYR_gMcRpocNW5Vv_9pJbJXBKHaLYaB_Uis&usqp=CAU",
];

const promotionImages = [
  "https://cjgdigitalmarketing.com/wp-content/uploads/2014/11/online-business-promotion.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNXXQ0o6nzn1B34IbGjXjKxrVdAdkavILdPLhhIOlhyoidB8pYvlalSg0lfmAw_F6Hfw0&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiRwD5u5xmvYxFHy7sBEZ8wYd_NT_3zSM20g&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdVa5Qm-XX8psf2IQtSq8zhBgdlqXCDvjL2A&usqp=CAU",
];
const userProfiles = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS47ASN-MW8K-nV9Ck_UZmUFmPF-vRavR5zOA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHQrdG2lH4OLmdUTGdv69Ubci9Ye8nM4_Q0g&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGujC5DzQ77Bi70CpaM3TlK-P_AkLr4ronKg&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5GJXhbYEhFovOt-xcoC3_D7JTlC_PINWCpQ&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRD_4J1hUQnSLEelceAU6WSh7Mnl4XzI5ADHA&usqp=CAU",
];/* 
final promotionList = [
  WeekPromotion(
    id: Uuid().v1(),
    image: promotionImages[0],
    desc: "Discount 10%",
    isPercentage: true,
    percentage: 10,
  ),
  WeekPromotion(
    id: Uuid().v1(),
    image: promotionImages[1],
    desc: "Discount 30%",
    isPercentage: true,
    percentage: 30,
  ),
  WeekPromotion(
    id: Uuid().v1(),
    image: promotionImages[2],
    desc: "Start from 15000MMK",
    isPercentage: false,
    descountPrice: 15000,
  ),
  WeekPromotion(
    id: Uuid().v1(),
    image: promotionImages[2],
    desc: "Start from 5000MMK",
    isPercentage: false,
    descountPrice: 5000,
  ),
];
 */