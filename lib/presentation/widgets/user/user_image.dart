import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';

class GroupBannerImage extends StatelessWidget {
  const GroupBannerImage({
    super.key,
    this.banner,
  });

  final String? banner;

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.5,
      color: MyTheme.placeholder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return banner != null
        ? CachedNetworkImage(
            imageUrl: banner!,
            errorWidget: (context, url, error) => _buildPlaceholder(context),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.5,
            fit: BoxFit.cover,
          )
        : _buildPlaceholder(context);
  }
}

class UserBannerImage extends StatelessWidget {
  const UserBannerImage({
    super.key,
    this.banner,
  });

  final String? banner;

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      color: MyTheme.placeholder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return banner != null
        ? CachedNetworkImage(
            imageUrl: banner!,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => _buildPlaceholder(context),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
          )
        : _buildPlaceholder(context);
  }
}

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    this.profile,
    this.size = 100,
  });

  final String? profile;
  final double size;

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: MyTheme.placeholder,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (profile != null) {
      return CachedNetworkImage(
        imageUrl: profile!,
        width: size,
        height: size,
        errorWidget: (context, url, error) => _buildPlaceholder(context),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider),
            shape: BoxShape.circle,
          ),
        ),
      );
    } else {
      return _buildPlaceholder(context);
    }
  }
}
