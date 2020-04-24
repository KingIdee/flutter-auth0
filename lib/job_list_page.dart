import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterauth0/job_model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class JobListPage extends StatefulWidget {
  @override
  _JobListPageState createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  List<Job> jobList;
  bool loading = false;
  bool error = false;

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  void fetchJobs() async {
    setState(() {
      loading = true;
    });

    http.get("https://jobs.github.com/positions.json?description=web")
        .then((result) {
      if (result.statusCode == 200) {
        setState(() {
          loading = false;
          jobList = JobList.fromJson(jsonDecode(result.body)).jobList;
        });
      } else {
        setState(() {
          loading = false;
          error = true;
        });
      }
    }).catchError((err) {
      setState(() {
        loading = false;
        error = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Jobs'),
      ),
      body: SafeArea(
        child: Container(
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 2,
                  ),
                )
              : error
                  ? Center(child: Text('Could not fetch jobs'))
                  : ListView.separated(
                      separatorBuilder: (_, c) => Divider(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(jobList[index].title),
                          subtitle: Text(jobList[index].companyName),
                          onTap: () {
                            launch(jobList[index].url);
                          },
                        );
                      },
                      itemCount: jobList.length,
                    ),
        ),
      ),
    );
  }
}
