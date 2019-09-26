class CompanyGalleryEvent {}

class LoadCompanyGallery extends CompanyGalleryEvent {
  final int companyId;

  LoadCompanyGallery(this.companyId);
}
