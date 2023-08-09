import 'package:flutter/material.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/utils/widgets/news_item_list.dart';
import 'package:news_app/view/news_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ApiService apiService = ApiService();

  TextEditingController searchController = TextEditingController();

  String searchText = 'news';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Search key word',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  searchText = searchController.text;
                                  searchController.clear();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                              );
                            },
                            icon: const Icon(Icons.search)),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: ApiService.fetchDataFromAPI(searchText),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5,
                      ),
                    );

                  default:
                    if (snapshot.hasError) {
                      return Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          child: const Text('Erro ao buscar as notícias'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NewsView(news: snapshot.data![index]),
                                ),
                              );
                            },
                            child: NewsItemList(
                              news: snapshot.data![index],
                            ),
                          );
                        },
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
