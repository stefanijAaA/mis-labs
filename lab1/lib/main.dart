import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class DetailView extends StatelessWidget {
  final Clothing item;

  const DetailView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text(
          item.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Image.network(item.image),
        SizedBox(height: 10),
        Text(
          item.price,
          style: TextStyle(fontSize: 20, color: Colors.green),
        ),
        SizedBox(height: 10),
        Text(
          item.description,
          style: TextStyle(fontSize: 16),
        ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Clothing {
  String name;
  String description;
  String image;
  String price;
  
  Clothing(this.name, this.description, this.image, this.price);
}

class _MyHomePageState extends State<MyHomePage> {
  List<Clothing> listClothes = [
    Clothing("T-shirt", "A comfortable cotton T-shirt", "https://shop.mango.com/assets/rcs/pics/static/T5/fotos/S/57010282_99.jpg?imwidth=640&imdensity=1&ts=1703000014268", "17\$"),
    Clothing("Jeans", "A pair of stylish denim jeans", "https://www.ganni.com/dw/image/v2/AAWT_PRD/on/demandware.static/-/Sites-ganni-master-catalogue/default/dwee1b96ca/images/images/model/J1641_6432_565_1.jpg?sh=2000", "25\$"),
    Clothing("Sweater", "A warm and cozy wool sweater", "https://leknit.com/images/produktbilleder/Siri-sweater-6-le-knit-lene-holme-samsoee-sams%C3%B8e-strikkeopskrift-p.jpg", "15\$"),
    Clothing("Jacket", "A stylish and warm jacket for cold weather", "https://hooke.ca/cdn/shop/files/HOOKE-MEN-LIGHTWEIGHT-INSULATED-HOOD-JACKET-BLK-1.webp?v=1689773252&width=1200", "40\$"),
    Clothing("Shorts", "Comfortable shorts for summer", "https://m.media-amazon.com/images/I/71o3seXJPQL._AC_SX569_.jpg", "13\$"),
    Clothing("Socks", "A pair of comfortable cotton socks", "https://cdni.llbean.net/is/image/wim/206990_9407_41", "3\$"),
  ];
  
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('206008'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listClothes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(listClothes[index].name),
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailView(item: listClothes[index]),
                    ),
                    );
                  },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
