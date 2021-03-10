import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/card_design.dart';
import 'package:ocean_project/desktopview/Components/image_to_text.dart';
import 'package:ocean_project/desktopview/Components/navigation_bar.dart';
import 'package:ocean_project/desktopview/Components/teext_to_image.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/screen/footer.dart';
import 'package:ocean_project/text.dart';

class Service extends StatefulWidget {
  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopNavigationBar(
              title: "Services",
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              'Our Services',
              style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: kfontname,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 50.0,
            ),
            Center(
              child: Wrap(
                children: [
                  ContainerServiceWidget(
                    title: ourservicesheading1,
                    content: ourservices1,
                    icon: 'images/campus-training.png',
                  ),
                  ContainerServiceWidget(
                    title: ourservicesheading2,
                    content: ourservices2,
                    icon: 'images/software devolopment.png',
                  ),
                  ContainerServiceWidget(
                    title: ourservicesheading3,
                    content: ourservices3,
                    icon: 'images/technical workshop.png',
                  ),
                  ContainerServiceWidget(
                    title: ourservicesheading4,
                    content: ourservices4,
                    icon: 'images/counseling.png',
                  ),
                  ContainerServiceWidget(
                    title: "Title",
                    content: "Subtitle",
                    icon: '',
                  ),
                  ContainerServiceWidget(
                    title: "Title",
                    content: "Subtitle",
                    icon: '',
                  ),
                ],
              ),
            ),
            ImageToText(
                topic: serviceheading1,
                content: servicecontent1,
                photo:
                    'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Fcorporate%20trining.svg?alt=media&token=73464595-cf57-4c7e-b7c6-5dea4d5009ae'),
            TextToImage(
              topic: serviceheading2,
              content: servicecontent2,
              photo:
                  'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Fcareer%20oriented.svg?alt=media&token=7dcee29f-ecea-4ed4-b4a5-485a90bdc3b2',
            ),
            ImageToText(
                topic: serviceheading3,
                content: servicecontent3,
                photo:
                    'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Fworkshops%20and%20value.svg?alt=media&token=6a4cc10d-a9c4-43f0-bf46-f0d6077a8456'),
            TextToImage(
              topic: serviceheading4,
              content: servicecontent4,
              photo:
                  'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Flearn%20new%20skil.svg?alt=media&token=1d608f76-07dc-48f2-951f-819cee6f0b92',
            ),
            SizedBox(
              height: 20.0,
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
