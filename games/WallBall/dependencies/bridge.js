var Bridge = function() {
	this.x = 4;
	console.log("constructor");
};

Bridge.prototype = {
	lives: function(lvs) {
		console.log("lives");
		console.log(this.x);
	}
	,cursor: function(cur) {
		console.log("cursor");
	}
	,percent: function(per) {
		console.log("percent");
	}
};
