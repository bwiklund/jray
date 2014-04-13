function foobar() {
  var methods = [ erasthenes, naivePrimes ];
  var method = methods[ ~~(Math.random() * methods.length) ];
  var primes = method( ~~(Math.random() * 100) + 10 );
  document.querySelector("#prime span").innerText = primes[ primes.length-1 ];
}
