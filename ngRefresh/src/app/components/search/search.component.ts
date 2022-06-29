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
    private router: Router
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
