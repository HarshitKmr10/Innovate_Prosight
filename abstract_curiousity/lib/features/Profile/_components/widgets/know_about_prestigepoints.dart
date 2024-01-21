import 'package:flutter/material.dart';

class KnowAboutEngagements extends StatefulWidget {
  const KnowAboutEngagements({super.key});

  @override
  State<KnowAboutEngagements> createState() => _KnowAboutEngagementsState();
}

class _KnowAboutEngagementsState extends State<KnowAboutEngagements> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.43,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          Row(
            children: [
              Spacer(),
              Center(
                child: Icon(
                  Icons.stadium_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                'Your Prestige Points',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            'Prestige represents the number of valuable interactions you had with the Abstract Community .',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.grey,
            thickness: 1,
          ),
          SizedBox(height: 20.0),
          Text(
            "\u2022 Prestige points increase when someone likes your comment, or if you add a bio or profile photo.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "\u2022 Prestige points decrease when someone downvotes your content.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "\u2022 If your Prestige points fall below AverageLevels, you will be suspended from posting and commenting.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
