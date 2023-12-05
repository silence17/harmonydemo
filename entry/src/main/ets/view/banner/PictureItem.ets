/**
 * Picture entity class.
 */
export class PictureItem {
  id: string;
  name: string;
  description: string;
  image: Resource;

  constructor(id: string, name: string, description: string, image: Resource) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.image = image;
  }
}