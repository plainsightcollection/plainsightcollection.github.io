var Bridge = function() {
  this.openflContent = document.getElementById("openfl-content");

  this.openflContent.oncontextmenu = function(e) {
      e.preventDefault(); 
      return true;
    };

};

Bridge.prototype = {
	lives: function(lvs) {
	}
	,cursor: function(cur) {
    this.openflContent.style.setProperty("cursor", cur);
	}
	,percent: function(per) {
	}
};
