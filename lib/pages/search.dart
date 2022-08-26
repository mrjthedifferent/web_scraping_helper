import 'package:flutter/material.dart';
import 'package:web_scraping_helper/product.dart';

class SearchResults extends StatelessWidget {
  final String title;
  final List<Product> results;

  const SearchResults(this.results, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: results.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              onTap: () {
                showDialog(context: context, builder: (context) => Image.network(
                  results[i].image,
                ));
              },
              leading: results[i].image.startsWith("http")
                  ? Image.network(
                      results[i].image,
                      height: 100,
                    )
                  : const SizedBox(height: 100),
              title: Text("${results[i].title} -- ${results[i].offText}"),
              subtitle: Text(results[i].desc),
              trailing: Text(results[i].price),
            ),
          );
        },
      ),
    );
  }
}
