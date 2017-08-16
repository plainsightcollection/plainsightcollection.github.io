var Cursor = function() {
  console.log("cursor constructor");
};

Cursor.prototype = {
  set: function(cur) {
    console.log("setting css to: " + cur);
    return;
  }
};
