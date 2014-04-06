angular.module 'jray'


.value "testFn1", """
function instrumentedFn() {
  var foo = 0;
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if( Math.random() > 0.1 ){
    return;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if( Math.random() > 0.5 ){
    return;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo = 1;
  }

  if( foo >= 4 ){
    doSomethingDumb();
  } else {
    doSomethingEquallyDumb();
  }

  doSomethingTotallyStupid();

  // make some primes for good measure
  erasthenes( ~~(Math.random() * 10) );
  isPrime( ~~(Math.random() * 1000) );

}
"""


.value "testFn2", """
function doSomethingDumb(){
  var a = 10;
  a += 5;
  a -= 5;
}

function doSomethingEquallyDumb(){
  var a = 10;
  a += 5;
  a -= 5;
  a += 5;
  a -= 5;
}

function doSomethingTotallyStupid(){
  var a = 1337;
}
"""


.value "testFn3", """
function erasthenes(limit) {
    var primes = [];
    if (limit >= 2) {
        var nums = new Array(limit-1);
        for (var i = 2; i <= limit; i++)
            nums[i-2] = i;
 
        var last_prime;
        var idx = 0;
        while ((last_prime = nums[idx]) <= Math.sqrt(limit)) {
            if (last_prime != null)
                for (var i = idx + last_prime; i < limit - 1; i += last_prime) 
                    nums[i] = null;
            idx++;
        }
        for (var i = 0; i < nums.length; i++)
            if (nums[i] != null)
                primes.push(nums[i]);
    }
    return primes;
}
"""


.value "testFn4", """
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
"""