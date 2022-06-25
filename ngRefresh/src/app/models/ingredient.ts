export class Ingredient {
  id: number | null;
  name: string | null;
  description: string | null;
  image_url: string | null;
  kcals_per_serving: number | null;

  constructor(
    id: number | null = 0,
    name: string | null = '',
    description: string | null = '',
    image_url: string | null = '',
    kcals_per_serving: number | null = 0
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.image_url = image_url;
    this.kcals_per_serving = kcals_per_serving;
  }
}
