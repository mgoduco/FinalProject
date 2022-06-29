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
  user: User = new User();
  newUser: User = new User();

  constructor(
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit(): void {}

  register(user: User) {
    console.log('Registering user: ');
    console.log(user);
    this.auth.register(user).subscribe({
      next: (registeredUser) => {
        if (user.username && user.password) {
          this.auth.login(user.username, user.password).subscribe({
            next: (loggedInUser) => {
              this.router.navigateByUrl('/home');
            },
            error: (fail) => {
              console.error(
                'RegisterComponent.register: error registering new user'
              );
              console.error(fail);
            },
          });
        }
      },
      error: (fail) => {
        console.error(
          'RegisterComponent.register(): Error registering account'
        );
        console.error(fail);
      },
    });
  }
}
