function naivePrimes( num ){
  var primes = [];
  for( var i = 0; i < num; i++ ){
    if( isPrime(i) ){
      primes.push( i );
    }
  }
}