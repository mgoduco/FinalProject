import { SearchComponent } from './../search/search.component';
import { Component, EventEmitter, OnInit, Output, TemplateRef, ViewChild } from '@angular/core';
import { NgbOffcanvas } from '@ng-bootstrap/ng-bootstrap';
import { faArrowLeft, faArrowRightFromBracket, faBacon, faBowlFood, faBowlRice, faBreadSlice, faBurger, faCarrot, faDrumstickBite, faEgg, faFish, faPieChart, faPizzaSlice, faTachographDigital, faUtensils, IconDefinition } from '@fortawesome/free-solid-svg-icons';
import { RecipeService } from 'src/app/services/recipe.service';
import { Recipe } from 'src/app/models/recipe';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { User } from 'src/app/models/user';


@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {

  // @ViewChild(SearchComponent) searchComp: any


  user: User = new User();
  keyword: string = '';
  recipes: Recipe [] = [];



  // Icons
  faArrowLeft = faArrowLeft;
   faBurger = faBurger;
   faCarrot = faCarrot;
   faBacon = faBacon;
   faFish = faFish;
   faPizzaSlice = faPizzaSlice;
   faDrumstickBite = faDrumstickBite;
   faUtensils = faUtensils;
   faEgg = faEgg;
   faBowlFood = faBowlFood;
   faBowlRice = faBowlRice;
   faBreadSlice = faBreadSlice;
   faArrowRightFromBracket = faArrowRightFromBracket;


  icons: IconDefinition [] =  [
    faEgg,
    faBurger,
    faCarrot,
    faBacon,
    faFish,
    faPizzaSlice,
    faDrumstickBite,
    faUtensils,
    faBowlFood,
    faBowlRice,
    faBreadSlice];



  constructor(private offcanvasService: NgbOffcanvas,
    private recipeServ: RecipeService,
    private route: ActivatedRoute,
    private router: Router,
    private auth: AuthService) { }

  ngOnInit(): void {
    this.getUser();
  }

  openEnd(content: TemplateRef<any>) {
    this.offcanvasService.open(content, { position: 'end' });
  }

  randomIcon(){
    return this.icons[Math.floor(Math.random() * this.icons.length)];
  }

  loggedIn(){
    return this.auth.checkLogin();
  }

  logOut(){
    this.auth.logout();
    this.router.navigateByUrl('/home').then(() => {
    this.reloadPage();
    });
  }

  reloadPage(){
  window.location.reload();
  }

  getUser(){
    this.auth.getLoggedInUser().subscribe({
      next: (data) => {
        this.user = data;
      }
    })
    console.log(this.user);


  }

}





