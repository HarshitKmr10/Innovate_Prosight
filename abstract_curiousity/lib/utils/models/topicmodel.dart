import 'package:abstract_curiousity/Features/HomePage/homepage.dart';
import 'package:abstract_curiousity/Features/UserRegisteration/services/auth_repository.dart';
import 'package:abstract_curiousity/globalvariables.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopicSelector {
  final Map<String, List<Map<String, dynamic>>> _categories = {
    'News': [
      {'topic': 'Tech', 'selected': false},
      {'topic': 'Gaming', 'selected': false},
      {'topic': 'EVs & Cars', 'selected': false},
      {'topic': 'Crypto', 'selected': false},
      {'topic': 'U.S. Politics', 'selected': false},
      {'topic': 'Int\'l Politics', 'selected': false},
      {'topic': 'Health', 'selected': false},
      {'topic': 'Science', 'selected': false},
      {'topic': 'Space', 'selected': false},
      {'topic': 'Stocks', 'selected': false},
      {'topic': 'Career', 'selected': false},
      {'topic': 'Finance', 'selected': false},
      {'topic': 'Climate Change', 'selected': false},
    ],
    'Lifestyle': [
      {'topic': 'TV & Movies', 'selected': false},
      {'topic': 'Internet Culture', 'selected': false},
      {'topic': 'Celebs', 'selected': false},
      {'topic': 'Travel', 'selected': false},
      {'topic': 'Recipes & Cooking', 'selected': false},
      {'topic': 'Beautiful Homes', 'selected': false},
      {'topic': 'Art & Design', 'selected': false},
      {'topic': 'Men\'s Style', 'selected': false},
      {'topic': 'Women\'s Style', 'selected': false},
      {'topic': 'Nature', 'selected': false},
      {'topic': 'Exercise', 'selected': false},
      {'topic': 'Books', 'selected': false},
      {'topic': 'Parenting', 'selected': false},
      {'topic': 'Education', 'selected': false},
      {'topic': 'Relationships', 'selected': false},
      {'topic': 'Wine & Drinks', 'selected': false},
      {'topic': 'Restaurants', 'selected': false},
      {'topic': 'Humor & Cartoons', 'selected': false},
    ],
    'Sports': [
      {'topic': 'NFL', 'selected': false},
      {'topic': 'NBA', 'selected': false},
      {'topic': 'MLB', 'selected': false},
      {'topic': 'F1', 'selected': false},
      {'topic': 'NCAAF', 'selected': false},
      {'topic': 'NCAAB', 'selected': false},
      {'topic': 'Golf', 'selected': false},
      {'topic': 'NHL', 'selected': false},
      {'topic': 'Tennis', 'selected': false},
      {'topic': 'Soccer', 'selected': false},
      {'topic': 'Cycling', 'selected': false},
    ],
  };

  // Getter method to retrieve topics for a specific category
  List<Map<String, dynamic>> getTopicsForCategory(String category) {
    return _categories[category] ?? [];
  }

  // Setter method to update the selection status of a topic
  void setTopicSelected(String category, String topic, bool selected) {
    final topics = _categories[category];
    if (topics != null) {
      final topicIndex = topics.indexWhere((item) => item['topic'] == topic);
      if (topicIndex != -1) {
        topics[topicIndex]['selected'] = selected;
      }
    }
  }
}

class TopicSelectorPage extends StatefulWidget {
  const TopicSelectorPage({super.key});

  @override
  State<TopicSelectorPage> createState() => _TopicSelectorPageState();
}

class _TopicSelectorPageState extends State<TopicSelectorPage> {
  final TopicSelector _topicSelector = TopicSelector();
  final AuthRepository _authRepository = AuthRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Map<String, Set<String>> convertToMap(List<List<String>> selectedTopics) {
    Map<String, Set<String>> topicMap = {};

    for (List<String> item in selectedTopics) {
      String category = item[0];
      String topic = item[1];

      // Check if the category already exists in the map
      if (topicMap.containsKey(category)) {
        topicMap[category]!.add(topic);
      } else {
        // If the category doesn't exist, create a new set and add the topic to it
        topicMap[category] = {topic};
      }
    }

    return topicMap;
  }

  void saveUser(List<List<String>> topics) {
    Map<String, Set<String>> topicMap = convertToMap(topics);
    printError(topicMap.toString());
    _authRepository.saveUsertoBackend(
        context: context, user: _firebaseAuth.currentUser!, topics: topicMap);
  }

//create a seetter _showNextButton
  bool _showContinueButton = false;
  List<List<String>> _selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: _topicSelector._categories.length,
          itemBuilder: (BuildContext context, int index) {
            final category = _topicSelector._categories.keys.elementAt(index);
            final topics = _topicSelector.getTopicsForCategory(category);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: topics.map(
                      (topic) {
                        return GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: topic['selected']
                                    ? Colors.white
                                    : Colors.white24,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              topic['topic'],
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: topic['selected']
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(
                              () {
                                _topicSelector.setTopicSelected(category,
                                    topic['topic'], !topic['selected']);
                                if (topic['selected']) {
                                  _selectedTopics
                                      .add([category, topic['topic']]);
                                } else {
                                  _selectedTopics.removeWhere((element) =>
                                      element[0] == category &&
                                      element[1] == topic['topic']);
                                }
                                if (_selectedTopics.isNotEmpty &&
                                    _selectedTopics.length >= 5) {
                                  _showContinueButton = true;
                                }
                                if (_selectedTopics.isEmpty) {
                                  _showContinueButton = false;
                                }
                              },
                            );
                          },
                        );
                      },
                    ).toList(),
                  ),
                  // GridView.builder(
                  //   gridDelegate:
                  //       const SliverGridDelegateWithMaxCrossAxisExtent(
                  //           maxCrossAxisExtent: 200,
                  //           childAspectRatio: 2.5,
                  //           crossAxisSpacing: 2,
                  //           mainAxisSpacing: 6),
                  //   shrinkWrap: true,
                  //   itemCount: topics.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     final topic = topics[index];

                  //   },
                  // ),
                ],
              ),
            );
          },
        ),
        if (_showContinueButton)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.9),
                fixedSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                saveUser(_selectedTopics);
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const HomePage(
                            pageNumber: 0,
                          )),
                );
              },
              child: const Text('Continue'),
            ),
          ),
      ],
    );
  }
}
