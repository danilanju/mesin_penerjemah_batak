import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_file/terjemah_cubit.dart';

class TabTerjemah extends StatelessWidget {
  const TabTerjemah({
    super.key,
    required TextEditingController textController,
  }) : _textController = textController;

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Input box
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(11),
              child: TextField(
                controller: _textController,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Masukkan teks di sini...',
                  hintStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ),

        // Tombol
        InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.only(right: 15),
            child: ElevatedButton(
              onPressed: () {
                TranslationCubit translationCubit =
                    context.read<TranslationCubit>();
                translationCubit.translateText(_textController.text);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.deepPurpleAccent.shade700,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Terjemahkan',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.send),
                ],
              ),
            ),
          ),
        ),

        // Output box
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 15),
                child: BlocBuilder<TranslationCubit, TranslationState>(
                  builder: (context, state) {
                    return SelectableText(
                      state.translatedText,
                      style:
                          TextStyle(fontSize: 18, color: Colors.grey.shade600),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
