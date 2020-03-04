describe("Task not performed as expected during synchronous event processing elm/virtual-dom#146", function() {
  before(function() {
    browser.url("/src/SyncEventNoCmds.elm");
    browser.captureConsoleLogs();
    $("#step-a").waitForExist();
  });

  it.only("shows current time", function() {
    $("#text-input").click();
    browser.keys("Enter");

    expect($("#step-c").isExisting()).to.be.true;
  });
});
