// lets calculate some small
// primes for no reason!

function foobar() {
  var methods = [ erasthenes, naivePrimes ];
  var method = methods[ ~~(Math.random() * methods.length) ];
  var primes = method( ~~(Math.random() * 100) + 10 );
  var el = document.querySelector("#prime span");
  el.innerText = primes[ primes.length-1 ];
}
