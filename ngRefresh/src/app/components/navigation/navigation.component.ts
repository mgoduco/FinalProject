import { Component, OnInit, TemplateRef } from '@angular/core';
import { NgbOffcanvas } from '@ng-bootstrap/ng-bootstrap';
import { faArrowLeft, faBacon, faBowlFood, faBowlRice, faBreadSlice, faBurger, faCarrot, faDrumstickBite, faEgg, faFish, faPieChart, faPizzaSlice, faTachographDigital, faUtensils, IconDefinition } from '@fortawesome/free-solid-svg-icons';


@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {

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



  constructor(private offcanvasService: NgbOffcanvas) { }

  ngOnInit(): void {
  }

  openEnd(content: TemplateRef<any>) {
    this.offcanvasService.open(content, { position: 'end' });
  }

  randomIcon(){
    return this.icons[Math.floor(Math.random() * this.icons.length)];

  }
  }

