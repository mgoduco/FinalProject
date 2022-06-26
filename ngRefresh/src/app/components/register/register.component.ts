import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
})
export class RegisterComponent implements OnInit {
  newUser: User = new User();

  constructor(
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit(): void {}

  register(user: User) {
    this.auth.register(this.newUser).subscribe({
      next: (user) => {
        console.log(user);
        console.log(this.newUser);
        this.newUser = new User();
      },
      error: (fail) => {
        console.error('RegisterComponent.register: error registering new user');
        console.error(fail);
      },
    });
  }
}
