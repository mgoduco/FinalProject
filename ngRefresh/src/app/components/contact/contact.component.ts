import { Component, OnInit } from '@angular/core';
import { faCodeBranch, faDatabase, faEnvelope, faTimeline } from '@fortawesome/free-solid-svg-icons';
import { faGithub, faGithubSquare, faLinkedin, faTwitter } from '@fortawesome/free-brands-svg-icons';
import { faFacebook } from '@fortawesome/free-brands-svg-icons';
import { faPhone } from '@fortawesome/free-solid-svg-icons';
import { faHeart as farHeart, faPenToSquare} from '@fortawesome/free-regular-svg-icons';
import { faHeart as fasHeart} from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.css']
})
export class ContactComponent implements OnInit {

  constructor() { }

  //FontAwesome icons for HTML
  faEnvelope = faEnvelope;
  faTwitter = faTwitter;
  faFacebook = faFacebook;
  faPhone = faPhone;
  faLinkedin = faLinkedin;
  faGithub = faGithub;
  faGithubSquare = faGithubSquare;
  faCodeBranch = faCodeBranch;
  faDatabase = faDatabase;
  faTimeLine = faTimeline;


  ngOnInit(): void {
  }

}
