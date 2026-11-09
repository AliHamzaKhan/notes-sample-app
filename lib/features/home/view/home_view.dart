import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_notes_app/core/theme/app_color.dart';
import '../../../app/routes.dart';
import '../../../app/utils/date_formats.dart';
import '../../../app/widgets/notes_card.dart';
import '../../../core/model/NoteModel.dart';
import '../controller/home_controller.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'My Notes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: controller.loadNotes,
        //     icon: const Icon(Icons.refresh),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.loadNotes,
          child: Column(
            children: [
              _buildSearchBox(context, controller),
              Expanded(
                child: _buildGridListing(context, controller),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.crud)?.then((value){
            controller.loadNotes();
          });
        },
        icon: const Icon(Icons.add),
        label: const Text('New Note'),
      ),
    );
  }

  Widget _buildSearchBox(
      BuildContext context,
      HomeController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextFormField(
        readOnly: true,
        onTap: (){
          Get.toNamed(AppRoutes.search);
        },
        onChanged: controller.searchNotes,
        decoration: InputDecoration(
          hintText: 'Search your notes...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildGridListing(
      BuildContext context,
      HomeController controller,
      ) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (controller.notes.isEmpty) {
        return _buildEmptyState();
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final crossAxisCount = width >= 1000
              ? 4
              : width >= 650
              ? 3
              : width >= 400
              ? 2
              : 1;

          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 190,
            ),
            itemCount: controller.notes.length,
            itemBuilder: (context, index) {
              final note = controller.notes[index];

              return buildNoteCard(context, controller, note);
            },
          );
        },
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 70,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'No Notes Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first note to get started.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }


}

final GlobalKey<NavigatorState> navigatorKey =
GlobalKey<NavigatorState>();