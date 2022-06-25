import { TestBed } from '@angular/core/testing';

import { RecipeIngredientService } from './recipe-ingredient.service';

describe('RecipeIngredientService', () => {
  let service: RecipeIngredientService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(RecipeIngredientService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
