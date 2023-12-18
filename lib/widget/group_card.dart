// import 'package:flutter/material.dart';
// import 'package:forus/model/card_data.dart';

// class GroupCard extends StatefulWidget {
//   const GroupCard({super.key});

//   @override
//   State<GroupCard> createState() => _GroupCardState();
// }

// class _GroupCardState extends State<GroupCard> {
//   List<CardData> datas = [
//     CardData(
//         title: 'FG/Programming',
//         description: 'Programming is fun, let\'s learn together',
//         imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
//     CardData(
//         title: 'FG/Navy',
//         description: 'Find out more about the Navy',
//         imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
//     CardData(
//         title: 'FG/Military',
//         description: 'Find out more about the Military',
//         imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
//     CardData(
//         title: 'FG/General',
//         description: 'You can talk about anything here',
//         imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
//     CardData(
//         title: 'FG/Food',
//         description: 'Yummy yummy in my tummy',
//         imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
//     CardData(
//         title: 'FG/Programming',
//         description: 'Programming is fun, let\'s learn together',
//         imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
//     CardData(
//         title: 'FG/Navy',
//         description: 'Find out more about the Navy',
//         imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
//     CardData(
//         title: 'FG/Military',
//         description: 'Find out more about the Military',
//         imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
//     CardData(
//         title: 'FG/General',
//         description: 'You can talk about anything here',
//         imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
//     CardData(
//         title: 'FG/Food',
//         description: 'Yummy yummy in my tummy',
//         imagePath: 'https://avatars.githubusercontent.com/u/81005238?v=4'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//       child: Padding(
//         padding: const EdgeInsets.all(13),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(datas.imagePath),
//                   radius: 30,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       datas.title,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       datas.description,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
