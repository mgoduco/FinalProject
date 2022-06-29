import { RecipeIngredientService } from './../../services/recipe-ingredient.service';
import { RecipeIngredient } from './../../models/recipe-ingredient';
import { IngredientService } from 'src/app/services/ingredient.service';
import { Ingredient } from './../../models/ingredient';
import { AuthService } from 'src/app/services/auth.service';
import { Recipe } from 'src/app/models/recipe';
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { RecipeService } from 'src/app/services/recipe.service';
import { UserService } from 'src/app/services/user.service';
import { faArrowLeft, faBowlFood, faCommentMedical, faCommentSlash, faPenToSquare, faTrash } from '@fortawesome/free-solid-svg-icons';
import { faHeart as farHeart} from '@fortawesome/free-regular-svg-icons';
import { faHeart as fasHeart} from '@fortawesome/free-solid-svg-icons';
import { User } from 'src/app/models/user';
import { ModalDismissReasons, NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { Comment } from 'src/app/models/comment';
import { CommentService } from './../../services/comment.service';

@Component({
  selector: 'app-recipe',
  templateUrl: './recipe.component.html',
  styleUrls: ['./recipe.component.css'],
})
export class RecipeComponent implements OnInit {
  recipes: Recipe[] = [];
  selected: null | Recipe = null;
  editSelected: null | Recipe = null;
  addIng: boolean = false;
  isSelected: boolean = false;
  isCreateTableSelected: boolean = false;
  recipeSelected: boolean = false;
  ingredients: Ingredient[] = [];
  allingredients: Ingredient[] = [];
  rIngredients: RecipeIngredient[] = [];
  newRecipe: Recipe = new Recipe();
  recipe: Recipe = new Recipe();
  user: User = new User();
  comments: Comment[] = [];
  comment: null | Comment = null;
  selectedComment: null | Recipe = null;
  newComment: Comment= new Comment(
    null,
    null,
    null,
    null,
    false,
    null,
    null,
    null
  );
  ingredient: Ingredient = new Ingredient(null, null, null, null, null, []);
  newRecipeIngredient: RecipeIngredient = new RecipeIngredient(
    this.recipe,
    this.ingredient,
    null,
    null,
    null
  );


  // Icons
  faArrowLeft = faArrowLeft;
  faTrash = faTrash;
  faPen = faPenToSquare;
  faPotFood = faBowlFood;
  famessage = faCommentSlash;
  farHeart = farHeart;
  fasHeart = fasHeart;
  facomment = faCommentMedical;
  faPenToSquare = faPenToSquare;

  // rIngredient: RecipeIngredient = new RecipeIngredient(
  //   this.recipe,
  //   this.ingredient,
  //   null,
  //   null,
  //   null
  // );

  closeResult = '';

  constructor(
    private ingredientServ: IngredientService,
    private recipeServ: RecipeService,
    private rIngredientServ: RecipeIngredientService,
    private userServ: UserService,
    private route: ActivatedRoute,
    private router: Router,
    private modalService: NgbModal,
    private commentServ: CommentService,
    private auth: AuthService
  ) {}

  ngOnInit(): void {
    this.getAllIngredients();
    this.getUser();
  }
  nArray(n: number): any[] {
    return Array(n);
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
    let username = this.user.username;
    if (username != null) {
      this.recipeServ.recipesByUsername(username).subscribe({
        next: (recipes) => {
          this.recipes = recipes;
          console.log(recipes);
        },
        error: (fail: any) => {
          console.error('RecipeComp.reload: error');
          console.error(fail);
        },
      });
    }
  }

  displayAddIngredient(string: boolean) {
    this.addIng = string;
  }
  displayUpdateTable(recipe: Recipe) {
    console.log(recipe);
    this.editSelected = recipe;
  }
  displayCreateTable(string: boolean) {
    this.isCreateTableSelected = string;
  }
  displayCreate() {
    this.isSelected = true;
  }

  displayRecipe(recipe: Recipe) {
    this.selected = recipe;
    this.recipeSelected = true;
    this.getIngredientsByrecipe(recipe.id);
    this.getRIngredientsByRecipe(recipe.id);
    if (recipe.id != null) {
      this.getRecipeComments(recipe.id);
    }
  }


  displayTable() {
    this.selected = null;
    this.isSelected = false;
    this.isCreateTableSelected = false;
    this.editSelected = null;
  }

  getIngredientsByrecipe(id: number) {
    console.log(id);
    this.ingredientServ.indexByRecipe(id).subscribe({
      next: (data) => {
        this.ingredients = data;
        console.log(data);
        this.ingredients.forEach((element) => {
          console.log(element.recipeIngredients);
        });
      },
      error: (fail: any) => {
        console.error('getIngredients: error');
        console.error(fail);
      },
    });
  }

  // TODO GET ALL INGREDIENTS TO ADD DROP DOWN FOR CREATE RECIPE INGREDIENTS....
  // DO NGFOR TODO EACH INGREDIENT IN DROP DOWN... AND INGREDIENT NAME IS LABEL--
  // ID IS VALUE
  getAllIngredients() {
    this.ingredientServ.index().subscribe({
      next: (data) => {
        this.allingredients = data;
        console.log(data);
      },
      error: (fail: any) => {
        console.error('getIngredients: error');
        console.error(fail);
      },
    });
  }
  // index ingredients

  addIngredient(recipe: Recipe) {
    this.recipeServ.create(recipe).subscribe({
      next: (newRecipe) => {
        this.selected = recipe;
        this.recipeSelected = true;
        this.newRecipe = new Recipe();
      },
      error: (fail) => {
        console.error(
          'RecipeComponent.createIngredient: error adding ingredient'
        );
        console.error(fail);
      },
    });
  }

  removeIngredient(id: number | null): void {
    if (id != null) {
      this.ingredientServ.destroy(id).subscribe({
        next: () => {
          this.reload();
          this.displayTable();
        },
      });
    }
  }

  // ???????????????
  createRecipeWithIngredients() {}

  createRecipe(recipe: Recipe) {
    this.recipeServ.create(recipe).subscribe({
      next: (newRecipe) => {
        this.selected = recipe;
        this.recipeSelected = true;
        this.newRecipe = new Recipe();
        this.reload();
        this.getIngredientsByrecipe(recipe.id);
        this.getRIngredientsByRecipe(recipe.id);
        this.displayCreateTable(false);
        this.displayUpdateTable(recipe);
      },
      error: (fail) => {
        console.error('RecipeComponent.createRecipe: error creating recipe');
        console.error(fail);
      },
    });
  }

  updateRecipe(recipe: Recipe) {
    this.recipeServ.update(recipe).subscribe({
      next: (newRecipe) => {
        this.newRecipe = new Recipe();
        this.reload();
        this.displayTable();
      },
      error: (fail) => {
        console.error('RecipeComponent.addTodo: error creating recipe');
        console.error(fail);
      },
    });
  }

  //TODO CANNOT DELETE RECIPE WITH ANY RECIPE INGREDIENTS, NEED METHOD FOR DELETING ALL RECIPE INGREDIENTS PUT INSIDE OF THIS
  deleteRecipe(id: number): void {
    this.recipeServ.delete(id).subscribe({
      next: () => {
        this.reload();
        this.reload();
        this.displayTable();
      },
    });
  }

  getRIngredientsByRecipe(id: number) {
    console.log(id);
    this.rIngredientServ.getForRecipe(id).subscribe({
      next: (data) => {
        this.rIngredients = data;
        console.log(data);
      },
      error: (fail: any) => {
        console.error('getRIngredientsByRecipe: error');
        console.error(fail);
      },
    });
  }

  createRecipeIngredient(
    rIngredient: RecipeIngredient,
    recipe: Recipe,
    ingredient: Ingredient
  ) {
    ingredient = this.ingredient;
    console.log(this.allingredients);
    console.log(this.ingredient);
    console.log(rIngredient);
    console.log(recipe.id);
    console.log('ingredient id' + ingredient.id);
    delete rIngredient.ingredient;
    delete rIngredient.recipe;
    if (recipe.id != null && ingredient.id != null) {
      this.rIngredientServ
        .create(rIngredient, recipe.id, ingredient.id)
        .subscribe({
          next: (newRecipeIngredient) => {
            this.newRecipeIngredient = new RecipeIngredient();
            console.log('R INGREDIENT' + rIngredient);
            console.log('recipe id' + recipe.id);
            console.log('ingredient id' + ingredient.id);
            this.reload();
            this.getRIngredientsByRecipe(recipe.id);
            this.displayUpdateTable(recipe);
          },
          error: (fail) => {
            console.error(
              'RecipeComponent.createRecipeIngredient: error creating recipe Ingredient'
            );
            console.error(fail);
          },
        });
    }
  }

  updateRecipeIngredient(
    rIngredient: RecipeIngredient,
    recipe: Recipe,
    ingredient: Ingredient
  ) {
    if (recipe.id != null && ingredient.id != null) {
      this.rIngredientServ
        .update(rIngredient, recipe.id, ingredient.id)
        .subscribe({
          next: (rIngredient) => {
            this.selected = recipe;
            this.recipeSelected = true;
            this.newRecipe = new Recipe();
            this.reload();
            this.displayTable();
          },
          error: (fail) => {
            console.error(
              'RecipeComponent.updateRecipeIngredient: error updating recipe'
            );
            console.error(fail);
          },
        });
    }
  }
  removeRecipeIngredient(recipe: Recipe, ingredient: Ingredient) {
    // if (recipe.id != null && ingredient.id != null) {
    console.log(ingredient);
    console.log(recipe);
    console.log(recipe.id);
    console.log('ingredient id' + ingredient.id);

    if (recipe && ingredient.id) {
      console.log('deleting ingredient')
      this.rIngredientServ.delete(recipe.id, ingredient.id).subscribe({
        next: (rIngredient) => {
        this.reload();
        this.getRIngredientsByRecipe(recipe.id);
        this.displayUpdateTable(recipe);
        },
        error: (fail) => {
          console.error(
            'RecipeComponent.removeRecipeIngredient: error creating recipe'
            );
            console.error(fail);
          },
        });
      }
    // }
  }

  // ________________________________Modal________________________________
  open(content: any) {
    this.modalService
      .open(content, { ariaLabelledBy: 'modal-basic-title' })
      .result.then(
        (result) => {
          this.closeResult = `Closed with: ${result}`;
        },
        (reason) => {
          this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
        }
      );
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

  @ViewChild('title') commentTitle: any; // accessing the reference element
  @ViewChild('commmentArea') commentSpace: any;

  handleClear(){
      // clearing the value
    this.commentTitle.nativeElement.value = ' ';
    this.commentSpace.nativeElement.value = ' ';
  }

  reloadPage() {
    window.location.reload();
 }

 loggedIn(){
  return this.auth.checkLogin();
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




}

// displayUserRecipes() {
//   this.recipeServ.recipesByUsername(this.user).subscribe({
//     next: (recipes) => {
//       this.recipes = recipes;
//       console.log(recipes);
//     },
//     error: (fail: any) => {
//       console.error('RecipeComp.reload: error');
//       console.error(fail);
//     },
//   });
// }
