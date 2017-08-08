var Bridge = function() {
  this.style = document.getElementById("openfl-content").style;
	console.log("constructor");
};

Bridge.prototype = {
	lives: function(lvs) {
		console.log("lives");
		console.log(this.x);
	}
	,cursor: function(cur) {
    this.style.setProperty("cursor", cur);
	}
	,percent: function(per) {
		console.log("percent");
	}
};
