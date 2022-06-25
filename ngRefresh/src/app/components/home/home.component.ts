import { RecipeService } from './../../services/recipe.service';
import { Component, OnInit, ViewChild } from '@angular/core';
import { NgbCarousel, NgbSlideEvent, NgbSlideEventSource } from '@ng-bootstrap/ng-bootstrap';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  constructor(recipe: RecipeService, route: ActivatedRoute,
    router: Router) { }

  ngOnInit(): void {
  }

  reload(){

  }





}


