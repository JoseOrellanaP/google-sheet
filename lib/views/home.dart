

import 'package:flutter/material.dart';
import 'package:google_sheet/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<FeedbackModel> feedbacks = <FeedbackModel>[];


  Future<List<FeedbackModel>> getFeedbackFromSheet() async{
    return await http.get(Uri.parse("https://script.google.com/macros/s/AKfycbwt7fITjm3Fxi6rzLf_cdMrNYcWH_Yaxx2Ry1vO8G7h4t6QN7bFZrTbjfkz2POFIEuN/exec")).then((raw){
      var jsonFeedback = convert.jsonDecode(raw.body) as List;
      return jsonFeedback.map((json) => FeedbackModel.fromJson(json)).toList();
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    //getFeedbackFromSheet();
    
    
    getFeedbackFromSheet().then((feedbacks){
      setState(() {
        this.feedbacks = feedbacks;
      });
    });

    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        elevation: 0,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: feedbacks.length,
          itemBuilder: (context, index){
            return FeedbackTile(
              profilePic: feedbacks[index].profilePic,
              name: feedbacks[index].name,
              source: feedbacks[index].source,
              feedback: feedbacks[index].feedback,
              sourceUrl: feedbacks[index].sourceUrl,
              
            );
          },
        ),
      ),
    );
  }
}

class FeedbackTile extends StatelessWidget {

  final String profilePic, name, source, feedback, sourceUrl;
  
  FeedbackTile({
      this.profilePic, this.name, this.source, this.feedback, this.sourceUrl
  }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                child: Builder(
                  builder: (context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40)),
                      child: Image.network(profilePic)
                      );
                  }
                ),
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text("From $source",
                    style: TextStyle(color: Colors.grey),)
                ],
                )
            ],
          ),
          SizedBox(height: 16.0,),
          Text(feedback)
        ],
      ),
    );
  }
}