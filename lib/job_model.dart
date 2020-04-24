class JobList {
  final List<Job> jobList;

  JobList({this.jobList});

  factory JobList.fromJson(List parsedJson) {
    var list = parsedJson;
    List<Job> newList = list.map((i) => Job.fromJson(i)).toList();
    return JobList(jobList: newList);
  }
}

class Job {
  String title;
  String companyName;
  String url;

  Job({this.title, this.companyName, this.url});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
        title: json['title'], companyName: json['company'], url: json['url']);
  }
}
