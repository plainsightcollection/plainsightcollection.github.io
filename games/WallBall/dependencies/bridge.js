var Bridge = function() {
  this.openflContent = document.getElementById("openfl-content");
  this.openflContent.oncontextmenu = function(e) {
      e.preventDefault(); 
      return true;
  };

  this.livesContent = document.getElementById("lives");
  this.percentContent = document.getElementById("percent");

};

Bridge.prototype = {
	,cursor: function(cur) {
    this.openflContent.style.setProperty("cursor", cur);
	}
	lives: function(lvs) {
    this.livesContent.innerHTML = lvs;
	}
	,percent: function(per) {
    this.percentContent.innerHTML = per + '%';
	}
};
