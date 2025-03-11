class CharacterAsset {
  final String key;
  final String name; // Tên nhân vật
  final String assetPath; // Đường dẫn asset
  final String picturePath;
  final int health; // Máu
  final int mana; // Mana
  final String weapon;

  CharacterAsset({
    required this.key,
    required this.name,
    required this.assetPath,
    required this.picturePath,
    required this.health,
    required this.mana,
    required this.weapon,
  });
}

final List<CharacterAsset> characterAssets = [
  CharacterAsset(
    key: 'warrior',
    name: 'Assassin',
    assetPath: 'characters/Assassin',
    picturePath: 'assets/characters/Assassin/Picture.png',
    health: 100,
    mana: 50,
    weapon: 'sword',
  ),
  CharacterAsset(
    key: 'warrior',
    name: 'Knight',
    assetPath: 'characters/Knight',
    picturePath: 'assets/characters/Knight/Picture.png',
    health: 200,
    mana: 30,
    weapon: 'sword',
  ),
  CharacterAsset(
    key: 'mage',
    name: 'Mage',
    assetPath: 'characters/Mage',
    picturePath: 'assets/characters/Mage/Picture.png',
    health: 80,
    mana: 150,
    weapon: 'magicStick',
  ),
  CharacterAsset(
    key: 'mage',
    name: 'Merlin',
    assetPath: 'characters/Merlin',
    picturePath: 'assets/characters/Merlin/Picture.png',
    health: 90,
    mana: 200,
    weapon: 'magicStick',
  ),
  CharacterAsset(
    key: 'warrior',
    name: 'Arthur',
    assetPath: 'characters/Arthur',
    picturePath: 'assets/characters/Arthur/Picture.png',
    health: 150,
    mana: 100,
    weapon: 'sword',
  ),
];
