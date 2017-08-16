var Cursor = function() {
  this.openflContent = document.getElementById("openfl-content");
  return;
};

Cursor.prototype = {
  set: function(cur) {
    this.openflContent.style.setProperty("cursor", cur);
    return;
  }
};
