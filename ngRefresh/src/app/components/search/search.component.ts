import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';
import { AuthService } from 'src/app/services/auth.service';
import { Ingredient } from './../../models/ingredient';
import { IngredientService } from 'src/app/services/ingredient.service';
import {
  Component,
  Input,
  OnInit,
  SimpleChanges,
  ViewChild,
} from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ModalDismissReasons, NgbModal, NgbOffcanvas } from '@ng-bootstrap/ng-bootstrap';
import { Recipe } from 'src/app/models/recipe';
import { RecipeService } from 'src/app/services/recipe.service';
import {
  faArrowLeft,
  faBurger,
  faCarrot,
  faBacon,
  faFish,
  faPizzaSlice,
  faDrumstickBite,
  faUtensils,
  faEgg,
  faBowlFood,
  faBowlRice,
  faBreadSlice,
  IconDefinition,
  faCircleMinus,
  faCommentMedical,
  faCommentSlash,
  faPenToSquare,
} from '@fortawesome/free-solid-svg-icons';
import { CommentService } from 'src/app/services/comment.service';
import { Comment } from 'src/app/models/comment';
import { faHeart as farHeart} from '@fortawesome/free-regular-svg-icons';
import { faHeart as fasHeart} from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css'],
})
export class SearchComponent implements OnInit {
  keyword: string = '';
  recipes: Recipe[] = [];
  ingredients: Ingredient[] = [];
  selected: null | Recipe = null;
  isSelected: boolean = false;
  recipe: null | Recipe = null;
  comment: null | Comment = null;
  newComment: Comment = new Comment(
    null,
    null,
    null,
    null,
    false,
    null,
    null,
    null
  );
  comments: Comment[] = [];
  closeResult = '';

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
  facomment = faCommentMedical;
  faminus = faCircleMinus;
  famessage = faCommentSlash;
  farHeart = farHeart;
  fasHeart = fasHeart;
  faPenToSquare = faPenToSquare;

  icons: IconDefinition[] = [
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
    faBreadSlice,
  ];

  constructor(
    private offcanvasService: NgbOffcanvas,
    private recipeServ: RecipeService,
    private route: ActivatedRoute,
    private commentServ: CommentService,
    private ingredientServ: IngredientService,
    private auth: AuthService,
    private modalService: NgbModal,
    private router: Router,
    private userServ: UserService
  ) {}

  ngOnInit(): void {
    this.router.routeReuseStrategy.shouldReuseRoute = () => false;
    console.log('INIT');
    let searchTerm = this.route.snapshot.paramMap.get('keyword');
    if (searchTerm != null) {
      this.keyword = searchTerm;
    }
    this.search(this.keyword);
  }

  randomIcon() {
    return this.icons[Math.floor(Math.random() * this.icons.length)];
  }

  displayRecipe(recipe: Recipe) {
    this.selected = recipe;
    this.isSelected = true;
    console.log(recipe);
    console.log(this.selected);
    let id = this.selected.id;
    if (id != null) {
      this.getIngredientsByrecipe(id);
      this.getRecipeComments(id);
    }
  }

  displayTable() {
    this.selected = null;
  }

  ngOnChanges(changes: SimpleChanges) {
    this.search(this.keyword);
  }

  search(keyword: string) {
    console.log('search');
    console.log(keyword);
    // this.keyword = this.nav.keyword;
    this.recipeServ.recipesByNameandIngredient(keyword).subscribe({
      next: (dbRecipes) => {
        this.recipes = dbRecipes;
        console.log(dbRecipes);
      },
      error: (fail: any) => {
        console.error('NavigationComponent.reload: error');
        console.error(fail);
      },
    });
  }

  searchIngredients(keyword: string) {
    console.log('search');
    console.log(keyword);
    // this.keyword = this.nav.keyword;
    this.ingredientServ.indexByName(keyword).subscribe({
      next: (data) => {
        this.ingredients = data;
        console.log(data);
      },
      error: (fail: any) => {
        console.error('NavigationComponent.reload: error');
        console.error(fail);
      },
    });
  }

  getIngredientsByrecipe(id: number) {
    console.log(id);
    this.ingredientServ.indexByRecipe(id).subscribe({
      next: (data) => {
        this.ingredients = data;
        console.log(data);
      },
      error: (fail: any) => {
        console.error('HomeComponent.reload: error');
        console.error(fail);
      },
    });
  }

  getRecipeComments(id: number) {
    console.log(id);
    this.commentServ.getAllCommentsByRecipe(id).subscribe({
      next: (data) => {
        this.comments = data;
        console.log(data);
      },
      error: (fail: any) => {
        console.error('HomeComponent.reload: error');
        console.error(fail);
      },
    });
  }

  createComment(comment: Comment, id: number) {
    console.log(comment);
    console.log(id);
    if(comment.comment == null){
      alert('Comment cannot be blank')
    }
    if (id != null && comment.comment != null) {
      comment.active = true;
      this.commentServ.create(comment, id).subscribe({
        next: (data) => {
          this.comment = data;
          console.log(data);
          this.getRecipeComments(id);
        },
        error: (fail: any) => {
          console.error('HomeComponent.reload: error');
          console.error(fail);
        },
      });
    }
  }

  deleteComment(comment: Comment, recipe: Recipe) {
    console.log(comment);
    console.log(recipe);
    let id = recipe.id;
    if (comment != null && recipe != null) {
      this.commentServ.delete(comment, recipe).subscribe({
        next: (data) => {
          this.comment = data;
          console.log(data);
          if (id != null) {
            this.getRecipeComments(id);
          }
        },
        error: (fail: any) => {
          console.error('HomeComponent.reload: error');
          console.error(fail);
        },
      });
    }
  }

  @ViewChild('title') commentTitle: any; // accessing the reference element
  @ViewChild('commmentArea') commentSpace: any;

  handleClear() {
    // clearing the value
    this.commentTitle.nativeElement.value = ' ';
    this.commentSpace.nativeElement.value = ' ';
  }

  reloadPage() {
    window.location.reload();
  }

  loggedIn() {
    return this.auth.checkLogin();
  }

  editComment(comment: Comment, recipe: Recipe){
    console.log(comment);
    console.log(recipe);
    // this.comment = comment;
    let id = recipe.id;
    if (comment != null && recipe != null) {
      this.commentServ.update(comment, recipe).subscribe({
        next: (data) => {
          this.comment = data;
          console.log(data);
          if (id != null) {
            this.getRecipeComments(id);
          }
        },
        error: (fail: any) => {
          console.error('HomeComponent.reload: error');
          console.error(fail);
        },
      });
    }
  }

  // ______________________________FAVORITES______________________________

  favorited: boolean = false;
  user: User = new User();


  hearted() {
    if (this.favorited) {
      return fasHeart;
    } else {
      return farHeart;
    }
  }

  toggleFavorite() {
    if (!this.favorited) {
      if (this.selected) {
        this.setFavorite(this.selected);
        this.reload();
      }
    } else {
      if (this.selected) {
        this.removeFavorite(this.selected);
        this.reload();
      }
    }
  }

  isFavorite(rid: number) {
    this.userServ.getFavorite(rid).subscribe({
      next: (favorite) => {
        console.log('Favorite get success!');
        this.favorited = true;
        return true;
      },
      error: (fail: any) => {
        console.log('Favorite is false.')
        this.favorited = false;
        return false;
      },
    });
  }

  setFavorite(recipe: Recipe) {
    let userId = this.user.id;
    console.log('User ID: ' + userId);
    console.log('Selected Recipe:');
    console.log(this.selected);
    if (this.selected !== null) {
      let recipeId = this.selected.id;
      console.log('Recipe ID: ' + recipeId);
      if (userId !== null && recipeId !== null) {
        console.log('Succeessfully created Favorite!');
        this.userServ.addFavorite(userId, recipeId).subscribe({
          next: (added) => {
            this.favorited = true;
          },
          error: (fail: any) => {
            console.error('FavoriteComponent.setFavorite: error');
            console.error(fail);
          },
        });
      }
    }
  }

  removeFavorite(recipe: Recipe) {
    let userId = this.user.id;
    console.log('User ID: ' + userId);
    console.log('Selected Recipe:');
    console.log(this.selected);
    if (this.selected !== null) {
      let recipeId = this.selected.id;
      console.log('Recipe ID: ' + recipeId);
      if (userId !== null && recipeId !== null) {
        console.log('Succeessfully removed Favorite!');
        this.userServ.removeFavorite(userId, recipeId).subscribe({
          next: (removed) => {
            this.favorited = false;
          },
          error: (fail: any) => {
            console.error('FavoriteComponent.removeFavorite: error');
            console.error(fail);
          },
        });
      }
    }
  }

  getUser() {
    this.auth.getLoggedInUser().subscribe({
      next: (data) => {
        this.user = data;
        this.reload();
      },
    });
    console.log(this.user);
  }

  reload() {
    console.log(this.user.username);
    let uid = this.user.id;
    if (uid != null) {
      this.userServ.getAllFavorites(uid).subscribe({
        next: (recipes) => {
          this.recipes = recipes;
          console.log(recipes);
        },
        error: (fail: any) => {
          console.error('FavoriteComponent.reload: error');
          console.error(fail);
        },
      });
    }
  }

  // _____________________________________________________________________

  // ________________________________Modal________________________________
  open(content: any) {
    this.modalService.open(content, {ariaLabelledBy: 'modal-basic-title'}).result.then((result) => {
      this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
      this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
    });
  }

  private getDismissReason(reason: any): string {
    if (reason === ModalDismissReasons.ESC) {
      return 'by pressing ESC';
    } else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
      return 'by clicking on a backdrop';
    } else {
      return `with: ${reason}`;
    }
  }


// ________________________________________________________________


}
