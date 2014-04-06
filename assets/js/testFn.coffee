angular.module 'jray'


.value "testFn", """
var instrumentedFn = function () {
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
}

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