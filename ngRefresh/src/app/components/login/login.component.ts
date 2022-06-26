import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  user: User = new User();

  constructor(
    private auth: AuthService,
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  login(user: User): void {
    console.log(user.username);
    console.log(user.password);
    if (user.username && user.password) {

      this.auth.login(user.username, user.password).subscribe({
        next: (loggedInUser) => {
          this.router.navigateByUrl('/todo');
        },
        error: (fail) => {
          console.error('LoginComponent.login: error logging in');
          console.error(fail);
        }
      });
    }
  }

}
