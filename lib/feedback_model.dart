class FeedbackModel{

  String profilePic;
  String name;
  String source;
  String feedback;
  String sourceUrl;


  FeedbackModel({
    this.profilePic, this.name, this.source,
    this.feedback, this.sourceUrl
  }
  );

  factory FeedbackModel.fromJson(dynamic json){
    return FeedbackModel(
      
      feedback: "${json['feedback']}",
      name: "${json['name']}",
      profilePic: "${json['profile_pic']}",
      source: "${json['source']}",
      sourceUrl: "${json['source_url']}",

/*
      "${json['profile_pic']}",
      "${json['name']}",
      "${json['source']}}",
      "${json['feedback']}}",
      "${json['source_url']}}",
*/
    );
  }

  Map toJson() => {
    'profile_pic': profilePic,
    'name': name,
    'source': source,
    'feedback': feedback,
    'source_url': sourceUrl,
    
  };

  

}