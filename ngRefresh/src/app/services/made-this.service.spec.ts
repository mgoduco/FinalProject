import { TestBed } from '@angular/core/testing';

import { MadeThisService } from './made-this.service';

describe('MadeThisService', () => {
  let service: MadeThisService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MadeThisService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
