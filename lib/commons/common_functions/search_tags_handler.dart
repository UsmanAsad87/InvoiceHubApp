Map<String, dynamic> userSearchTagsHandler({
  required String fName,
  required String email,
}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  if (fName.isNotEmpty) {
    fName.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  if (email.isNotEmpty) {
    email.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  return searchTags;
}

Map<String, dynamic> productSearchTagHandler({
  required String productName,
}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  productName.trim().split(' ').forEach((val) {
    searchTags[val.toLowerCase()] = true;
  });

  return searchTags;
}


Map<String, dynamic> invoiceSearchTagsHandler({
  required String fName,
  required String companyName,
}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  if (fName.isNotEmpty) {
    fName.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  if (companyName.isNotEmpty) {
    companyName.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  return searchTags;
}