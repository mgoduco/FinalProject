import { Component, Input, OnInit, SimpleChanges } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbOffcanvas } from '@ng-bootstrap/ng-bootstrap';
import { Recipe } from 'src/app/models/recipe';
import { RecipeService } from 'src/app/services/recipe.service';
import { faArrowLeft, faBurger, faCarrot, faBacon, faFish, faPizzaSlice, faDrumstickBite, faUtensils, faEgg, faBowlFood, faBowlRice, faBreadSlice, IconDefinition } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {




  keyword: string = '';
  recipes: Recipe [] = [];
  selected: null | Recipe = null;
  isSelected: boolean = false;
  recipe: null | Recipe = null;



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
    private router: Router) { }

  ngOnInit(): void {
    this.router.routeReuseStrategy.shouldReuseRoute = () => false;
    console.log("INIT");
    let searchTerm = this.route.snapshot.paramMap.get('keyword');
    if (searchTerm != null){
      this.keyword = searchTerm;
    }
    this.search(this.keyword);

  }



  randomIcon(){
    return this.icons[Math.floor(Math.random() * this.icons.length)];
  }

  displayRecipe(recipe: Recipe) {
    this.selected = recipe;
    this.isSelected = true;
    console.log(recipe);
    console.log(this.selected);
  }

  displayTable() {
    this.selected = null;
  }

  ngOnChanges(changes: SimpleChanges){
    this.search(this.keyword);
  }

  search(keyword: string){
    console.log('search')
    console.log(keyword);
    // this.keyword = this.nav.keyword;
    this.recipeServ.recipesByNameandIngredient(keyword).subscribe({
      next: (dbRecipes) => {this.recipes = dbRecipes; console.log(dbRecipes)},
      error: (fail: any) => {
        console.error('NavigationComponent.reload: error');
        console.error(fail);
      }
    })
}

}
