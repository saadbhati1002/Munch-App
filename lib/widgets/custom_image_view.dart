import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:app/utility/images.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CustomImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? imagePath;
  final bool? isAssetsImage;

  const CustomImage(
      {super.key, this.height, this.imagePath, this.width, this.isAssetsImage});

  @override
  Widget build(BuildContext context) {
    return isAssetsImage == true
        ? SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              imagePath!,
              fit: BoxFit.fill,
            ),
          )
        : (imagePath != null && imagePath!.isNotEmpty)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: "${AppConstant.imagePath}$imagePath",
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return Shimmer.fromColors(
                      baseColor: Theme.of(context).hoverColor,
                      highlightColor: Theme.of(context).highlightColor,
                      enabled: true,
                      child: Container(
                        height: height,
                        width: width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorConstant.white,
                          border: Border.all(
                              width: 1, color: ColorConstant.greyColor),
                          image: const DecorationImage(
                            image: AssetImage(Images.logo),
                          ),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Shimmer.fromColors(
                      baseColor: Theme.of(context).hoverColor,
                      highlightColor: Theme.of(context).highlightColor,
                      enabled: true,
                      child: Container(
                        height: height,
                        width: width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorConstant.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1, color: ColorConstant.greyColor),
                          image: const DecorationImage(
                            image: AssetImage(Images.logo),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(
                height: height,
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorConstant.white,
                  border: Border.all(width: 1, color: ColorConstant.greyColor),
                  image: const DecorationImage(
                    image: AssetImage(Images.logo),
                  ),
                ),
              );
  }
}
