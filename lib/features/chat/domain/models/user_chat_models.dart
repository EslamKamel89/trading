// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserChat {
  final String id;
  final String name;
  final String surname;
  // final String imageUrl;
  UserChat({
    required this.id,
    required this.name,
    required this.surname,
    // required this.imageUrl,
  });
  static List<UserChat> usersChatStatic = [
    UserChat(id: '1', name: 'Eslam', surname: 'Kamel'),
    UserChat(id: '2', name: 'Selia', surname: 'Eslam'),
    UserChat(id: '3', name: 'Osmam', surname: 'Fathi'),
    UserChat(id: '4', name: 'Monuir', surname: 'Zaki'),
    UserChat(id: '5', name: 'Mostafa', surname: 'Ahmed'),
    UserChat(id: '6', name: 'Gamal', surname: 'Fawsy'),
    UserChat(id: '7', name: 'Yossef', surname: 'Ahmed'),
  ];
}
