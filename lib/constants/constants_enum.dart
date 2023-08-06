enum MessageType { text,image }

extension MessageTypeExtenstion on MessageType {
  static Map names = {
    MessageType.text: 'text',
    MessageType.image: 'image',
  };

  static Map types = {
    'text': MessageType.text,
    'image': MessageType.image,
  };

  String get name => names[this];
  MessageType getType(String text) => types[text];
}
