class Idea {
  final String id;
  final String title;
  final String description;
  final String author;
  final String authorProfilePicUrl; // NOVO: URL da imagem do autor
  final String timeAgo;
  final int likes;
  final int comments;

  Idea({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.authorProfilePicUrl,
    required this.timeAgo,
    this.likes = 0,
    this.comments = 0,
  });
}

class RankingUser {
  final int position;
  final String name;
  final String profilePicUrl; // NOVO: URL da imagem para o ranking
  
  RankingUser({required this.position, required this.name, required this.profilePicUrl});
}

class Comment {
  final String author;
  final String authorPicUrl;
  final String text;
  final String timeAgo;

  Comment({required this.author, required this.authorPicUrl, required this.text, required this.timeAgo});
}