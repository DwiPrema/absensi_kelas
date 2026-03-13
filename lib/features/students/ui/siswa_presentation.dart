// import 'package:absensi_kelas/core/constant/app_colors.dart';
// import 'package:absensi_kelas/widgets/text_widget.dart';
// import 'package:flutter/material.dart';

// class SiswaPresentation extends StatefulWidget {
//   const SiswaPresentation({super.key});

//   @override
//   State<SiswaPresentation> createState() => _SiswaPresentationState();
// }

// class _SiswaPresentationState extends State<SiswaPresentation> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: AppColors.bgBlue,
//       body: SafeArea(
//           child: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
//               child: Column(
//                 children: [
//                   Center(
//                     child: textInriaSans("Task Management",
//                         fontSize: 16,
//                         fontWeight: FontWeight.w800,
//                         textAlign: TextAlign.center),
//                   ),
//                   const SizedBox(height: 50),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           textPoppins(day,
//                               fontSize: 24,
//                               fontWeight: FontWeight.w300,
//                               align: TextAlign.left),
//                           textInter(dateAndMonth,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w300,
//                               align: TextAlign.left),
//                         ],
//                       ),
//                       Button(
//                           text: "Add Task",
//                           textColor: AppColors.primaryColor,
//                           bgColor: AppColors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           borderRadius: BorderRadius.circular(5),
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const TaskCreatePage()));
//                           }),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//           DraggableScrollableSheet(
//             snap: true,
//             initialChildSize: 0.75,
//             maxChildSize: 1.0,
//             minChildSize: 0.75,
//             builder: (context, scrollController) {
//               return Container(
//                 decoration: const BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(35)),
//                 ),
//                 child: Column(
//                   children: [
//                     SingleChildScrollView(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       controller: scrollController,
//                       child: Column(
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(top: 16),
//                             width: 70,
//                             height: 6,
//                             decoration: BoxDecoration(
//                               color: AppColors.black.withAlpha(50),
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: SingleChildScrollView(
//                               physics: const AlwaysScrollableScrollPhysics(),
//                               controller: scrollController,
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: Status.values.map((s) {
//                               final index = Status.values.indexOf(s);

//                               return _StatusCategory(
//                                   label: s.name.toUpperCase(),
//                                   onTap: () {
//                                     _pageController.animateToPage(index,
//                                         duration:
//                                             const Duration(milliseconds: 05),
//                                         curve: Curves.easeOut);
//                                     setState(() {
//                                       status = s;
//                                     });
//                                     _watchTodos();
//                                   },
//                                   isSelected: status == s);
//                             }).toList(),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 24,
//                     ),
//                     Expanded(
//                       child: PageView.builder(
//                           controller: _pageController,
//                           onPageChanged: (index) {
//                             setState(() {
//                               status = Status.values[index];
//                             });
//                           },
//                           itemCount: Status.values.length,
//                           itemBuilder: (context, pageIndex) {
//                             return StreamBuilder<List<Todo>>(
//                                 stream: DatabaseService.db.todos
//                                     .filter()
//                                     .statusEqualTo(status)
//                                     .watch(fireImmediately: true),
//                                 builder: (context, snapshot) {
//                                   if (!snapshot.hasData) {
//                                     return const SizedBox.shrink();
//                                   }

//                                   final data = snapshot.data!;

//                                   if (data.isEmpty) {
//                                     return Center(
//                                       child: textPoppins("No Task Yet",
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400,
//                                           color: AppColors.black),
//                                     );
//                                   }

//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 16),
//                                     child: ListView.builder(
//                                         itemCount: data.length,
//                                         itemBuilder: (context, index) {
//                                           final todo = data[index];

//                                           final isEdited =
//                                               todo.updatedAt != null;

//                                           final displayDate = isEdited
//                                               ? todo.updatedAt!
//                                               : todo.createdAt;

//                                           final locale =
//                                               Localizations.localeOf(context)
//                                                   .toString();

//                                           final dateNow = DateFormat(
//                                                   'EEE, dd MMMM yyyy', locale)
//                                               .format(displayDate);
//                                           final timeNow = DateFormat.jm(locale)
//                                               .format(displayDate);

//                                           return Padding(
//                                             padding: const EdgeInsets.only(
//                                                 bottom: 16),
//                                             child: TodoCard(
//                                                 onTapEdit: () {
//                                                   Navigator.push(context,
//                                                       MaterialPageRoute(
//                                                           builder: (context) {
//                                                     return TaskCreatePage(
//                                                       todo: todo,
//                                                     );
//                                                   }));
//                                                 },
//                                                 onTapRemove: () =>
//                                                     _removeAlert(todo),
//                                                 title: todo.title,
//                                                 description: todo.description,
//                                                 status:
//                                                     "status : ${todo.status.name}",
//                                                 date: isEdited
//                                                     ? "updated at : $dateNow. $timeNow"
//                                                     : "created at : $dateNow. $timeNow"),
//                                           );
//                                         }),
//                                   );
//                                 });
//                           }),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       )),
//     );
//   }

//   /// use this for remove task alert
//   void _removeAlert(Todo todo) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             icon: const Icon(
//               Icons.delete,
//               size: 35,
//             ),
//             title: textPoppins("Are you sure to remove this task ?",
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.black),
//             content: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(
//                   height: 24,
//                 ),
//                 textInter("Title : ${todo.title}",
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.black,
//                     align: TextAlign.left),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 textPoppins("Description : ${todo.description}",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w300,
//                     color: AppColors.black,
//                     align: TextAlign.left),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 textPoppins("Status : ${todo.status.name}",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w300,
//                     color: AppColors.black,
//                     align: TextAlign.left),
//                 const SizedBox(
//                   height: 16,
//                 ),
//               ],
//             ),
//             actions: [
//               Button(
//                   text: "remove",
//                   textColor: AppColors.white,
//                   bgColor: AppColors.primaryColor,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   borderRadius: BorderRadius.circular(100),
//                   onPressed: () async {
//                     await DatabaseService.db.writeTxn(
//                       () async {
//                         await DatabaseService.db.todos.delete(todo.id);
//                       },
//                     );

//                     if (!context.mounted) return;
//                     Navigator.pop(context);
//                   }),
//               Button(
//                   text: "cancel",
//                   textColor: AppColors.black,
//                   bgColor: AppColors.black.withAlpha(50),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   borderRadius: BorderRadius.circular(100),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }),
//             ],
//           );
//         });
//   }
// }

// /// A class used for display status chip (pending, in progress, completed)
// class _StatusCategory extends StatelessWidget {
//   final String label;
//   final VoidCallback onTap;
//   final bool isSelected;

//   const _StatusCategory(
//       {required this.label, required this.onTap, required this.isSelected});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           decoration: BoxDecoration(
//             color: isSelected ? AppColors.primaryColor : AppColors.secColor,
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: textPoppins(label,
//               fontSize: 10,
//               fontWeight: FontWeight.w400,
//               color: isSelected ? AppColors.white : AppColors.black)),
//     );
//   }
// }
