import 'package:flutter/material.dart';
import 'package:twitter_text_field/view_model.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key, this.drawerKey}) : super(key: key);
  final GlobalKey<ScaffoldState>? drawerKey;

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddPostViewModel>(
      builder: (_, model, __) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(),
          body: ListView(
            children: <Widget>[
              _buildTextField(),
              _buildSuggestion(),
              _buildActionButtons(),
            ],
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0.9,
      centerTitle: true,
      title: const Text(
        'Add Post',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Consumer<AddPostViewModel>(builder: (_, model, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: model.controller,
          maxLines: null,
          onChanged: model.handleTextChange,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Write here what do you want to share",
          ),
        ),
      );
    });
  }

  Widget _buildSuggestion() {
    return Consumer<AddPostViewModel>(
      builder: (_, model, __) {
        if (model.showHashtagList) {
          return SizedBox(
            height: 200,
            child: ListView(
              children: List.generate(
                model.fetchedhashtags.length,
                (index) => ListTile(
                  title: Text("#${model.fetchedhashtags[index]}"),
                  onTap: () => model.onTagClick(
                    model.fetchedhashtags[index],
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Row(
        children: <Widget>[
          // button to select the photo from gallery.
          IconButton(
            key: const Key('add_post_icon_button2'),
            onPressed: () => {},
            icon: const Icon(Icons.photo),
          ),
          // button to capture the image.
          IconButton(
            key: const Key('add_post_icon_button3'),
            onPressed: () => {},
            icon: const Icon(Icons.camera_alt),
          ),
          // button to select file
          IconButton(
            key: const Key('add_post_icon_button4'),
            onPressed: () {},
            icon: const Icon(Icons.file_upload),
          ),
        ],
      ),
    );
  }
}
