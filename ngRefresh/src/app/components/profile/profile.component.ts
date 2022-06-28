import { UserService } from 'src/app/services/user.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})

export class ProfileComponent implements OnInit {

  user: User = new User();
  isUrl: boolean = false;
  // editing: boolean = false;
  editUser: null | User = null;
  idNum: number = 0;

  constructor(
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute,
    private userServ: UserService
  ) { }


  ngOnInit(): void {
    this.getUser();


    // let idStr = this.route.snapshot.paramMap.get('id');
    // console.log(this.editUser);
    // console.log(idStr);
    // if (idStr) {
    //   this.idNum = Number.parseInt(idStr);
    //   console.log('idNum: ' + this.idNum);
    //   if (!isNaN(this.idNum)) {

    //     this.userServ.getUserById(this.idNum).subscribe({
    //       next: (theUser) => {
    //         this.user = theUser;
    //       },
    //       error: (fail) => {
    //         this.router.navigateByUrl('/userNotFound');
    //       },
    //     });
    //   }
    //   else {
    //     this.router.navigateByUrl('/invalidUserId');
    //   }
    // }
    // this.displayProfile();
  }

  // getUser(){
  //   console.log(this.auth.getUser());

  // }

  // *** THIS IS BECAUSE I DON'T KNOW HOW TO FETCH A USER FOR THE PROFILE PAGE ***
  // *** NOT FINISHED ***
  // ngOnInit(): void {
  //   let credentials = this.auth.getCredentials();
  //   if (credentials) {
  //     let userStr = this.auth.getUsername(credentials);
  //     console.log(this.editUser);
  //     console.log(userStr);
  //     if (userStr) {
  //         this.userServ.getUserById(this.idNum).subscribe({
  //           next: (theUser) => {
  //             this.user = theUser;
  //           },
  //           error: (fail) => {
  //             this.router.navigateByUrl('/userNotFound');
  //           },
  //         });
  //       }
  //       else {
  //         this.router.navigateByUrl('/invalidUserId');
  //       }
  //     this.displayProfile();
  //   }
  // }

  setEditProfile() {
    this.editUser = Object.assign({}, this.user);
  }

  updateProfile(editUser: User, setSelected: boolean = true) {
    this.userServ.update(editUser).subscribe({
      next: (updated) => {
        this.displayProfile();
        if (setSelected) {
          this.user = updated;
        }
        this.editUser = null;
      },
      error: (nojoy) => {
        console.error('ProfileComponent.updateProfile: error on update');
        console.error(nojoy);
      }
    });
  }

  displayProfile() {
    this.editUser = null;
    this.router.navigateByUrl('/u').then(() => {
      this.reloadPage();
      });
  }

  getUser(){
    this.auth.getLoggedInUser().subscribe({
      next: (data) => {
        this.user = data;
      }
    })
    console.log(this.user);
  }

  reloadPage() {
    window.location.reload();
  }

}
