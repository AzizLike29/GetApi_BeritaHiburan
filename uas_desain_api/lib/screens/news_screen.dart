import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../services/api_service.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ApiService data = ApiService();
  late List<NewsModel> newsList = [];
  late List<NewsModel> filteredNewsList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    final news = await data.getNews();
    setState(() {
      newsList = news;
      filteredNewsList = newsList;
    });
  }

  void filterNews(String query) {
    setState(() {
      filteredNewsList = newsList.where((news) {
        final titleLower = news.title.toLowerCase();
        final descriptionLower = news.description.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower) ||
            descriptionLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita Hiburan'),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: Colors.pink[50],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: filterNews,
              decoration: InputDecoration(
                labelText: 'Cari berita Anda',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredNewsList.length,
              itemBuilder: (context, index) {
                final news = filteredNewsList[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        news.images.small,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            "https://cdn.vox-cdn.com/thumbor/OD6A4Oo4W1s-2o9J34_s1twqFO0=/0x0:3000x2000/1200x628/filters:focal(1500x1000:1501x1001)/cdn.vox-cdn.com/uploads/chorus_asset/file/23926023/acastro_STK048_02.jpg",
                            fit: BoxFit.cover,
                            cacheHeight: 150,
                          );
                        },
                      ),
                    ),
                    title: Text(
                      news.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(news.description),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
