import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/common/components/primary_button.dart';
import 'package:twitter_clone/view/common/components/primary_text_field.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>();
    final currentUser = userViewModel.currentUser!;
    String? userIcon = currentUser.userIcon;
    Image iconImage = Image(
        image: CachedNetworkImageProvider(
            currentUser.userIcon ?? "https://placehold.jp/150x150.png"));
    String? userName = currentUser.userName;
    final nameController = userViewModel.nameController;
    nameController.text = userName;
    String? bio = currentUser.bio;
    final bioController = userViewModel.bioController;
    bioController.text = bio ?? "";

    return Scaffold(
      body: Consumer<UserViewModel>(
        builder: (context, model, child) {
          return model.isProcessing
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  padding: const EdgeInsets.all(40),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text("戻る"),
                        ),
                        TextButton(
                          onPressed: () async {
                            await model
                                .updateUserInfo()
                                .then((value) => context.pop());
                          },
                          child: const Text("完了"),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async {
                          await model.getImage(isFromGallery: true);
                          if (model.isImagePicked) {
                            iconImage = Image.file(model.imageFile!);
                          }
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: iconImage.image,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    PrimaryTextField(
                      controller: nameController,
                      isEdit: true,
                      hintText: "ユーザー名",
                    ),
                    const SizedBox(height: 10),
                    PrimaryTextField(
                      controller: bioController,
                      isEdit: true,
                      hintText: "プロフィール文章",
                      isMultiLine: true,
                      maxLines: 8,
                      height: 200,
                    ),
                  ],
                );
        },
      ),
    );
  }
}
