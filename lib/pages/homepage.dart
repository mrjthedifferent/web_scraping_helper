import 'package:flutter/material.dart';
import 'package:web_scraping_helper/pages/search.dart';
import 'package:web_scraping_helper/product.dart';

import '../services/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    List<Product> scrappedData = [];
    String text = '';

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  onChanged: (value){
                    text = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                    hintText: 'Search From Tatacliq',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        scrappedData = await getScrappedData(text);
                        setState(() {
                          isLoading = false;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResults(scrappedData, text),
                            ),
                          );
                        });
                      },
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Container(),
              const SizedBox(height: 20),
              Text("* Although tatacliq.com is built using react framework, it loads data on page runtime."),
              Text("* That's why It loads 12 products & 4 images first time."),
              Text("* It can be optimized but difficult task."),

            ],
          ),
        ),
      ),
    );
  }
}
