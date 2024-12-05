import 'package:flutter/material.dart';

void main() {
  runApp(CommunityApp());
}

class CommunityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Community',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CommunityPage(),
    );
  }
}

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final List<Map<String, String>> profiles = [
    {'name': 'Dr. Sarah', 'image': 'https://randomuser.me/api/portraits/women/44.jpg'},
    {'name': 'Dr. Mike', 'image': 'https://randomuser.me/api/portraits/men/46.jpg'},
    {'name': 'Dr. Emma', 'image': 'https://randomuser.me/api/portraits/women/47.jpg'},
    {'name': 'Dr. James', 'image': 'https://randomuser.me/api/portraits/men/48.jpg'},
    {'name': 'Dr. Anna', 'image': 'https://randomuser.me/api/portraits/women/49.jpg'},
  ];

  final List<Map<String, String>> newsFeed = [
    {
      'title': '5 Tips for Better Heart Health',
      'description': 'Simple lifestyle changes can greatly improve your heart health...',
      'image': 'https://source.unsplash.com/featured/?heart,health',
      'content': 'Detailed article on heart health tips...'
    },
    {
      'title': 'COVID-19: What You Need to Know',
      'description': 'Stay updated on the latest safety guidelines and vaccine updates...',
      'image': 'https://source.unsplash.com/featured/?covid,health',
      'content': 'Comprehensive COVID-19 safety and vaccine updates...'
    },
    {
      'title': 'Mental Health Awareness',
      'description': 'Understand the importance of mental well-being and seek help when needed...',
      'image': 'https://source.unsplash.com/featured/?mentalhealth',
      'content': 'An article focusing on mental health awareness and resources...'
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredProfiles = profiles
        .where((profile) =>
            profile['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    final filteredNews = newsFeed
        .where((news) =>
            news['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search profiles or topics...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),

            // Profiles Section
            Text(
              'Community Profiles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredProfiles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileDetailPage(
                            name: filteredProfiles[index]['name']!,
                            image: filteredProfiles[index]['image']!,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(filteredProfiles[index]['image']!),
                          ),
                          SizedBox(height: 8),
                          Text(
                            filteredProfiles[index]['name']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            // Medical News Section
            Text(
              'Latest Medical News',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredNews.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailPage(
                              title: filteredNews[index]['title']!,
                              image: filteredNews[index]['image']!,
                              content: filteredNews[index]['content']!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.network(
                              filteredNews[index]['image']!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredNews[index]['title']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  filteredNews[index]['description']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailPage extends StatelessWidget {
  final String name;
  final String image;

  ProfileDetailPage({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(image),
            ),
            SizedBox(height: 16),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Specialist in Internal Medicine',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text(
              'About Dr. $name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Dr. $name is an experienced medical professional with over 10 years of expertise in their field. They are committed to providing the best care to their patients and staying updated with the latest medical advancements.',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String content;

  NewsDetailPage({required this.title, required this.image, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
