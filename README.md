# jray

watch your code run in real time

![jray example](https://raw.github.com/bwiklund/jray/master/examples/jray.gif)

a work in progress. built with istanbul and angularjs.

to use without requirejs, include jray's js and css, and then change your script tags to `type="text/jray"`

```html
<link rel="stylesheet" href="jray.css">
<script src="jray.min.js"></script>

<script type="text/jray" src="scripts/one.js"></script>
<script type="text/jray" src="scripts/two.js"></script>
<script type="text/jray" src="scripts/three.js"></script>
<script type="text/jray" src="scripts/four.js"></script>
```

# Development

bug tickets and pull requests are extremely welcome.

to build:

```
npm install
gulp dev
```

# TODO:

- requirejs plugin
- move UI to iframe to avoid collisions with other versions of angular
