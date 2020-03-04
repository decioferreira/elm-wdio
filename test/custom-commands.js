browser.addCommand("captureConsoleLogs", function() {
  this.executeScript(
    "window.logs = []; console.log = function(msg) { window.logs.push(msg) };",
    []
  );
});

browser.addCommand("consoleLogs", function() {
  return this.executeScript("return window.logs;", []);
});
