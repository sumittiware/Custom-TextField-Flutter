import 'package:flutter/material.dart';
import 'package:twitter_text_field/widgets/post_controller.dart';

class AddPostViewModel extends ChangeNotifier {
  final PostTextController _controller = PostTextController();
  final List<String> _fetchedhashtags = [];
  bool _showHashtagList = false;

  PostTextController get controller => _controller;
  List<String> get fetchedhashtags => [..._fetchedhashtags];
  bool get showHashtagList => _showHashtagList;

  MapEntry<int, int> _getCurrentString() {
    final text = _controller.text;
    final cursorPosition = _controller.selection;
    int cursorIndex = cursorPosition.extentOffset - 1;
    int left = 0, right = 0;

    int temp = cursorIndex;
    while (temp > 0) {
      if (text[temp] == ' ' || text[temp] == '\n') {
        left = temp + 1;
        break;
      }
      temp--;
    }
    if (temp == 0) {
      left = 0;
    }
    temp = cursorIndex;

    while (temp < text.length) {
      if (text[temp] == ' ' || text[temp] == '\n') {
        right = temp;
        break;
      }
      temp++;
    }
    if (temp == text.length) {
      right = text.length;
    }
    return MapEntry(left, right);
  }

  List<String> _fetchTags(String prefix) {
    final tags = [
      "CodeNewbie",
      "ProgrammingHumor",
      "DevCommunity",
      "StackOverflow",
      "Github",
      "CodeChallenge",
      "CodeReview",
      "TechTalk",
      "CleanCode",
      "DeveloperLife",
      "WebDevelopment",
      "SoftwareEngineering",
      "OpenSource",
      "JavaScript",
      "Flutter",
      "Flask",
      "Java",
      "CSharp",
      "PHP",
      "ReactJS",
      "AngularJS",
      "NodeJS",
      "VueJS",
      "TypeScript",
      "GraphQL",
      "DevOps",
      "AgileMethodology",
      "MobileDevs",
      "ContinuousIntegration",
      "Git",
      "CodeQuality",
      "BackendDevelopment",
      "FrontendDevelopment",
      "MobileDevelopment",
      "TestAutomation",
      "SoftwareArchitecture",
      "Microservices",
      "Serverless",
      "CloudComputing",
      "MachineLearning",
      "ArtificialIntelligence",
      "DataScience",
      "BigData",
      "Blockchain",
      "Cryptocurrency",
      "Cybersecurity",
      "Hackathon",
    ];

    return tags
        .where((element) => element.toLowerCase().startsWith(prefix))
        .toList();
  }

  void onTagClick(String tag) {
    final list = _controller.text.split(' ');

    final vals = _getCurrentString();
    final currString = _controller.text.substring(vals.key, vals.value);

    int index = list.indexOf(currString);

    if (index != -1) {
      list[index] = "#$tag";
    } else {
      list.add("#$tag");
    }

    _controller.text = list.join(' ');

    _controller.selection = TextSelection.fromPosition(
      TextPosition(
        offset:
            (index == -1) ? _controller.text.length : vals.key + tag.length + 1,
      ),
    );

    _showHashtagList = false;

    notifyListeners();
  }

  void handleTextChange(_) {
    final vals = _getCurrentString();
    final currText = _controller.text.substring(vals.key, vals.value);

    if (currText == '#' || currText.startsWith('#')) {
      _fetchedhashtags.clear();
      if (currText.length > 1) {
        _fetchedhashtags.addAll(_fetchTags(currText.substring(1)));
      }
      _showHashtagList = true;
    } else {
      _showHashtagList = false;
    }

    notifyListeners();
  }
}
