function foobar() {

  // make some primes for good measure
  erasthenes( ~~(Math.random() * 10) );
  isPrime( ~~(Math.random() * 2000) );

  var foo = 0;
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if( Math.random() > 0.1 ){
    return;
  }

  if( Math.random() > 0.5 ){
    doSomethingDumb();
  } else {
    doSomethingEquallyDumb();
  }

  doSomethingTotallyStupid();

}
