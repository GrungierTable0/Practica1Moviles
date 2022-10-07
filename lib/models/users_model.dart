class UsersDAO{
  int? idUser;
  String? imageUser;
  String? nameUser;
  String? emailUser;
  String? phoneUser;
  String? gitUser;

  UsersDAO({this.idUser,this.imageUser,this.nameUser,this.emailUser,this.phoneUser,this.gitUser});
  factory UsersDAO.fromJSON(Map<String, dynamic> mapUser) {
    return UsersDAO(
      idUser: mapUser['idUser'],
      imageUser: mapUser['imageUser'],
      nameUser: mapUser['nameUser'],
      emailUser: mapUser['emailUser'],
      phoneUser: mapUser['phoneUser'],
      gitUser: mapUser['gitUser'],
    );
  }
    

}