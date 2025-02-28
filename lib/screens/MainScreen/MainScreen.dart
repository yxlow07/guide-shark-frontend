import 'package:flutter/material.dart';
import 'package:guide_shark/data/MedicalData.dart';
import 'package:guide_shark/screens/Questions/MainAreaOfConcern.dart';
import 'package:guide_shark/screens/Questions/Radiation.dart';
import '../../common/AppColors.dart';
import '../../common/widgets/BottomNavbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/MedicalDataCubit.dart';
import '../../data/MedicalDataState.dart';
import '../../common/widgets/BodyPartSelector.dart';
import '../Questions/PainCharacter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = MedicalDataCubit();

        final initialPages = [
          MainAreaOfConcern().mainAreaOfConcern(cubit),
          PainCharacter().painCharacter(cubit),
          Radiation().radiation(cubit),
        ];

        cubit.emit(cubit.state.copyWith(pages: initialPages));
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: BlocConsumer<MedicalDataCubit, MedicalDataState>(
                listener: (context, state) {
                  if (_pageController.hasClients &&
                      _pageController.page?.round() != state.currentPageIndex) {
                    _pageController.jumpToPage(state.currentPageIndex);
                  }
                },
                builder: (context, state) {
                  final cubit = context.read<MedicalDataCubit>();
                  return Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          children:
                              state.pages.map((page) {
                                return Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: page,
                                );
                              }).toList(),
                          onPageChanged: (index) {
                            cubit.emit(
                              cubit.state.copyWith(currentPageIndex: index),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed:
                                  state.currentPageIndex > 0
                                      ? () {
                                        cubit.previousPage();
                                        _pageController.previousPage(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                      : null,
                              child: const Text('Previous'),
                            ),
                            ElevatedButton(
                              onPressed:
                                  state.currentPageIndex <
                                          state.pages.length - 1
                                      ? () {
                                        cubit.nextPage();
                                        _pageController.nextPage(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                      : () {
                                        MedicalData finalData =
                                            cubit.getFormData();
                                        print(
                                          'Form Data Submitted: $finalData',
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Form Submitted!'),
                                          ),
                                        );
                                      },
                              child: Text(
                                state.currentPageIndex < state.pages.length - 1
                                    ? 'Next'
                                    : 'Submit',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            bottomNavigationBar: BottomNavbar.bottomNavigationBar,
          );
        },
      ),
    );
  }
}
