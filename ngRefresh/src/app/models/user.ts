export class User {
  id: number | null;
  username: string | null;
  password: string | null;
  email: string | null;
  role: string | null;
  enabled: boolean | false;
  // created
  // updated
  image_url: string | null;
  firstname: string | null;
  lastname: string | null;
  biography: string | null;

  constructor(
    id: number | null = 0,
    username: string | null = '',
    password: string | null = '',
    email: string | null = '',
    role: string | null = '',
    enabled: boolean = false,
    // created
    // updated
    image_url: string | null = '',
    firstname: string | null = '',
    lastname: string | null = '',
    biography: string | null = ''
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.email = email;
    this.role = role;
    this.enabled = enabled;
    this.image_url = image_url;
    this.firstname = firstname;
    this.lastname = lastname;
    this.biography = biography;
  }
}
