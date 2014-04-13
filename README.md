# jray

Watch your javascript run in real time

[Live demo ->](https://rawgit.com/bwiklund/jray/master/examples/index.html)

![demo gif](https://raw.github.com/bwiklund/jray/master/examples/jray.gif)

A work in progress. Built with istanbul and angularjs.

To use without requirejs, include jray's js and css, and then change your script tags to `type="text/jray"`

```html
...
<link rel="stylesheet" href="jray.css">
<script src="jray.min.js"></script>

<script type="text/jray" src="scripts/one.js"></script>
<script type="text/jray" src="scripts/two.js"></script>
<script type="text/jray" src="scripts/three.js"></script>
<script type="text/jray" src="scripts/four.js"></script>
...
```

# Development

TODO:

- requirejs plugin
- slideout from the side/top
- paginate script lines
- move UI to iframe to avoid collisions with other versions of angular
- support more ui modes (fade/add/etc)
- other color schemes
- node support???

Bug tickets and pull requests are extremely welcome.

To build:

```
npm install
gulp dev
```
