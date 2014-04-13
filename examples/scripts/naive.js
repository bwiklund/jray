function isPrime(n) {
  if (n == 2) {
    return true;
  } else if ((n < 2) || (n % 2 == 0)) {
    return false;
  } else {
    for (var i = 3; i <= Math.sqrt(n); i += 2) {
      if (n % i == 0)
        return false;
    }
    return true;
  }
}

function naivePrimes( num ){
  var primes = [];
  for( var i = 0; i < num; i++ ){
    if( isPrime(i) ){
      primes.push( i );
    }
  }
  return primes;
}