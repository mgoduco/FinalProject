import { Component, OnInit } from '@angular/core';
import { faTwitter } from '@fortawesome/free-brands-svg-icons';
import { faEnvelope } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.css']
})
export class ContactComponent implements OnInit {

  constructor() { }

  faTwitter = faTwitter;
  faEnvelope = faEnvelope;

  ngOnInit(): void {
  }

}
